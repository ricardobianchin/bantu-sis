unit Sis.UI.Frame.Bas_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TBasFrame = class(TFrame)
  private
    { Private declarations }
    FSelecionaProximo: boolean;
    function GetSelecionaProximo: boolean;
    procedure SetSelecionaProximo(Value: boolean);
  protected
    procedure EditKeyDown(Sender:TObject; var Key:word; Shift: TShiftState); virtual;
    procedure EditKeyPress(Sender: TObject; var Key: Char; pCharExceto:string=''); virtual;
    property SelecionaProximo: boolean read GetSelecionaProximo write SetSelecionaProximo;
    procedure SelecioneProximo(CurControl: TWinControl);
  public
    { Public declarations }
    procedure AjusteControles; virtual;
    constructor Create(AOwner: TComponent); override;
    procedure DebugImporteTeclas;
  end;

implementation

{$R *.dfm}

uses Sis.Types.strings_u, Sis.Types.Utils_u, Sis.UI.IO.Files, Sis.UI.Controls.Utils;

{ TBasFrame }

procedure TBasFrame.AjusteControles;
begin

end;

constructor TBasFrame.Create(AOwner: TComponent);
begin
  inherited;
  FSelecionaProximo := True;
  if AOwner is TWinControl then
    Parent := TWinControl(AOwner);
  ShowHint := True;
  AjusteControles;
end;

procedure TBasFrame.DebugImporteTeclas;
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

procedure TBasFrame.EditKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin

end;

procedure TBasFrame.EditKeyPress(Sender: TObject; var Key: Char;
  pCharExceto: string);
begin
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
//    if SelecionaProximo then
    if Sender is TWinControl then
      SelecioneProximo(TWinControl(Sender));
    exit;
  end;

  CharSemAcento(Key);
end;

function TBasFrame.GetSelecionaProximo: boolean;
begin
  Result := FSelecionaProximo;
end;

procedure TBasFrame.SelecioneProximo(CurControl: TWinControl);
begin
  if not SelecionaProximo then
    exit;

  SelectNext(CurControl, true, true);
end;

procedure TBasFrame.SetSelecionaProximo(Value: boolean);
begin
  FSelecionaProximo := Value;
end;

end.
