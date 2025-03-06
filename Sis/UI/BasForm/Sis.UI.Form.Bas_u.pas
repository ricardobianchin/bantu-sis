unit Sis.UI.Form.Bas_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TBasForm = class(TForm)
    ShowTimer_BasForm: TTimer;
    procedure FormShow(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);

  private
    { Private declarations }
    FKeyPressFiltraTeclado: boolean;
    FSelecionaProximo: boolean;
    FSempreDisparaOnShow: Boolean;
//    FDisparaShowTimer: Boolean;
    FFezShow: boolean;
//    function GetDisparaShowTimer: Boolean;
//    procedure SetDisparaShowTimer(Value: Boolean);

    procedure DispareShowTimer;

    function GetSelecionaProximo: boolean;
    procedure SetSelecionaProximo(Value: boolean);

  protected
//    property DisparaShowTimer: Boolean read GetDisparaShowTimer write SetDisparaShowTimer;
    property SempreDisparaOnShow: Boolean read FSempreDisparaOnShow write FSempreDisparaOnShow;
    property SelecionaProximo: boolean read GetSelecionaProximo write SetSelecionaProximo;
    procedure SelecioneProximo;

    procedure EditKeyDown(Sender:TObject; var Key:word; Shift: TShiftState);virtual;
    procedure EditKeyPress(Sender: TObject; var Key: Char); virtual;
    procedure CheckBoxKeyPress(Sender: TObject; var Key: Char); virtual;

    function GetKeyPressFiltraTeclado: boolean;
    procedure SetKeyPressFiltraTeclado(Value: boolean);
    property KeyPressFiltraTeclado: boolean read GetKeyPressFiltraTeclado write SetKeyPressFiltraTeclado;

    procedure DebugImporteTeclas;
    procedure AjusteControles; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;

  end;

var
  BasForm: TBasForm;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, Sis.DB.DBTypes, Sis.Types.Utils_u, Sis.UI.Controls.Utils,
  Sis.UI.IO.Files.Factory, Sis.UI.IO.Files;

procedure TBasForm.AjusteControles;
begin

end;

procedure TBasForm.CheckBoxKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
//    if SelecionaProximo then
    SelecioneProximo;
    exit;
  end;
end;

constructor TBasForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FKeyPressFiltraTeclado := True;
//  FDisparaShowTimer := False;
  FSelecionaProximo := True;
  FFezShow := False;
  FSempreDisparaOnShow := False;
end;

procedure TBasForm.DebugImporteTeclas;
var
  sNomeArq: string;
  sl: TStringList;
  s: string;
  Resultado: Boolean;
  sPastaDebug: string;
begin
  inherited;
  // s := ActiveControl.Name;

  sPastaDebug := GetPastaDoArquivo(ParamStr(0));
  sPastaDebug := PastaAcima(sPastaDebug);
  sPastaDebug := sPastaDebug+'Configs\Debug\';
  sPastaDebug := sPastaDebug + Sis.Types.Utils_u.ObterHierarquiaDeClasses(ClassType);
  sNomeArq := sPastaDebug + '\' + 'Teclas.txt';
  GarantirPastaDoArquivo(sNomeArq);
  Resultado := FileExists(sNomeArq);
  if not Resultado then
    exit;

  sl := TStringList.Create;
  try
    sl.LoadFromFile(sNomeArq);
    s := sl.Text;
    DigiteStr(s, 0);
  finally
    sl.Free;
  end;
end;

destructor TBasForm.Destroy;
begin
  inherited;
end;

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

procedure TBasForm.EditKeyPress(Sender: TObject; var Key: Char);
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

procedure TBasForm.FormShow(Sender: TObject);
begin
  if not FFezShow then
  begin
    //if not FSempreDisparaOnShow then
    //FFezShow := True;
    FFezShow := not FSempreDisparaOnShow;

    DispareShowTimer;
  end;
end;

//function TBasForm.GetDisparaShowTimer: Boolean;
//begin
//  Result := FDisparaShowTimer;
//end;

function TBasForm.GetKeyPressFiltraTeclado: boolean;
begin
  Result := FKeyPressFiltraTeclado;
end;

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

procedure TBasForm.SetKeyPressFiltraTeclado(Value: boolean);
begin
  FKeyPressFiltraTeclado := Value;
end;

procedure TBasForm.SetSelecionaProximo(Value: boolean);
begin
  FSelecionaProximo := Value;
end;

procedure TBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  ShowTimer_BasForm.Enabled := False;
  AjusteControles;
end;

end.
