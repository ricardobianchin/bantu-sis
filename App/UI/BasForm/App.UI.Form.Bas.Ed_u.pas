unit App.UI.Form.Bas.Ed_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas.Diag.Btn_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Data.DB, App.Ent.Ed, App.Ent.DBI, App.AppObj;

type
  TEdBasForm = class(TDiagBtnBasForm)
    ObjetivoLabel: TLabel;
  private
    { Private declarations }
    FEntEd: IEntEd;
    FEntDBI: IEntDBI;
    FAppObj: IAppObj;
    procedure AjusteCaption;
    procedure AjusteObjetivo;
  protected
    property AppObj: IAppObj read FAppObj;
    property EntEd: IEntEd read FEntEd;
    property EntDBI: IEntDBI read FEntDBI;

    procedure AjusteControles; override;

    procedure ControlesToEnt; virtual; abstract;
    procedure EntToControles; virtual; abstract;

    function GetObjetivoStr: string; virtual; abstract;

    function PodeOk: Boolean; override;
    function ControlesOk: Boolean; virtual;
    function DadosOk: Boolean; virtual;
    function GravouOk: Boolean; virtual; abstract;

    procedure AtualizeAlteracaoTexto; override;

    procedure ComboKeyPress(Sender: TObject; var Key: Char);
    procedure ComboExit(Sender: TObject);

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI); reintroduce; virtual;
  end;

var
  EdBasForm: TEdBasForm;

implementation

{$R *.dfm}

uses App.DB.Utils, Sis.UI.IO.Input.Perg,
  App.UI.Controls.ComboBox.Select.DB.Frame_u, Sis.Types.strings_u;

{ TEdBasForm }

procedure TEdBasForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom: string;
begin
  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        EntToControles;
      end;

    dsInsert:
      begin
        sFormat := 'Novo %s';
        sNom := EntEd.NomeEnt;
        sCaption := Format(sFormat, [sNom]);
        ObjetivoLabel.Caption := sCaption;
        EntEd.LimparEnt;
        EntToControles;
      end;
  end;

  AjusteCaption;
  AjusteObjetivo;

end;

procedure TEdBasForm.AjusteObjetivo;
var
  sObjetivo: string;
begin
  sObjetivo := GetObjetivoStr;
  ObjetivoLabel.Caption := sObjetivo;
end;

procedure TEdBasForm.AtualizeAlteracaoTexto;
begin
  if EntEd.State <> dsEdit then
  begin
    AlteracaoTextoLabel.Visible := false;
    exit;
  end;
  inherited;
end;

procedure TEdBasForm.AjusteCaption;
var
  sCaption: string;
  sTitulo, sState: string;
begin
  sTitulo := EntEd.Titulo;
  sState := DataSetStateToTitulo(EntEd.State);

  sCaption := Format('%s - %s', [sTitulo, sState]);

  Caption := sCaption;
end;

procedure TEdBasForm.ComboExit(Sender: TObject);
var
  Combo: TComboBox;
  Fr: TComboBoxSelectDBFrame;
begin
  if not(Sender is TComboBox) then
    exit;

  Combo := TComboBox(Sender);

  if not(Combo.Owner is TComboBoxSelectDBFrame) then
    exit;

  Fr := TComboBoxSelectDBFrame(Combo.Owner);
  if Fr.Id = 0 then
  begin
    Fr.ExibaMens('Obrigatório');
  end;
end;

procedure TEdBasForm.ComboKeyPress(Sender: TObject; var Key: Char);
var
  Combo: TComboBox;
  Fr: TComboBoxSelectDBFrame;
begin
  if not(Sender is TComboBox) then
    exit;

  Combo := TComboBox(Sender);

  if (Combo.Owner is TComboBoxSelectDBFrame) then
  begin
    Fr := TComboBoxSelectDBFrame(Combo.Owner);
    Fr.ComboBox1KeyPress(Combo, Key);
  end;

  if Key = #13 then
  begin
    Key := #0;
    SelecioneProximo;
  end;
  CharSemAcento(Key);
end;

function TEdBasForm.ControlesOk: Boolean;
begin
  Result := True;
end;

constructor TEdBasForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(AOwner);
  FAppObj := pAppObj;
  FEntEd := pEntEd;
  FEntDBI := pEntDBI;
end;

function TEdBasForm.DadosOk: Boolean;
var
  sFrase: string;
begin
  Result := EntEd.State in [dsEdit, dsInsert];
  if not Result then
  begin
    sFrase := 'O Status da janela não permite a gravação';
    ErroOutput.Exibir(sFrase);
    exit;
  end;
end;

function TEdBasForm.PodeOk: Boolean;
begin
  Result := Inherited PodeOk;
  if not Result then
    exit;

  Result := ControlesOk;
  if not Result then
    exit;
  AppObj.CriticalSections.DB.Acquire;
  try
    Result := DadosOk;
    if not Result then
      exit;

    ControlesToEnt;

    Result := GravouOk;
    if not Result then
      exit;
  finally
    AppObj.CriticalSections.DB.Release;
  end;
end;

end.
