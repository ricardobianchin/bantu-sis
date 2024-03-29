unit Sis.UI.Form.Bas_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TBasForm = class(TForm)
    ShowTimer_BasForm: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

  private
    { Private declarations }
    FSelecionaProximo: boolean;
//    FDisparaShowTimer: Boolean;
    FFezShow: boolean;
//    function GetDisparaShowTimer: Boolean;
//    procedure SetDisparaShowTimer(Value: Boolean);
    procedure DispareShowTimer;

    function GetSelecionaProximo: boolean;
    procedure SetSelecionaProximo(Value: boolean);

  protected
//    property DisparaShowTimer: Boolean read GetDisparaShowTimer write SetDisparaShowTimer;

    property SelecionaProximo: boolean read GetSelecionaProximo write SetSelecionaProximo;
    procedure SelecioneProximo;

    procedure EditKeyDown(Sender:TObject; var Key:word; Shift: TShiftState);virtual;
    procedure EditKeyPress(Sender: TObject; var Key: Char; pCharExceto:string='');virtual;

  public
    { Public declarations }

  end;

var
  BasForm: TBasForm;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, Sis.DB.DBTypes, Sis.Types.Utils_u;

procedure TBasForm.DispareShowTimer;
begin
//  if not FDisparaShowTimer then
//    exit;

  ShowTimer_BasForm.Enabled := True;
end;

procedure TBasForm.EditKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin

end;

procedure TBasForm.EditKeyPress(Sender: TObject; var Key: Char;
  pCharExceto: string);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
//    if SelecionaProximo then
    SelecioneProximo;
    exit;
  end;

  CharSemAcento(Key);
end;

procedure TBasForm.FormCreate(Sender: TObject);
begin
//  FDisparaShowTimer := False;
  FSelecionaProximo := True;
  FFezShow := False;
end;

procedure TBasForm.FormShow(Sender: TObject);
begin
  if not FFezShow then
  begin
    FFezShow := True;
    DispareShowTimer;
  end;
end;

//function TBasForm.GetDisparaShowTimer: Boolean;
//begin
//  Result := FDisparaShowTimer;
//end;

function TBasForm.GetSelecionaProximo: boolean;
begin
  Result := FSelecionaProximo;
end;

procedure TBasForm.SelecioneProximo;
begin
  if not SelecionaProximo then
    exit;

  SelectNext(ActiveControl, true, true);
end;

//procedure TBasForm.SetDisparaShowTimer(Value: Boolean);
//begin
//  FDisparaShowTimer := Value;
//end;

procedure TBasForm.SetSelecionaProximo(Value: boolean);
begin
  FSelecionaProximo := Value;
end;

procedure TBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  ShowTimer_BasForm.Enabled := False;
end;

end.
