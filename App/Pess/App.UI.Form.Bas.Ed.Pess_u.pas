unit App.UI.Form.Bas.Ed.Pess_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Buttons, App.Ent.Ed, App.Ent.DBI, App.AppInfo, App.Pess.Ent,
  App.Pess.DBI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, App.Pess.Ender.Frame_u;

type
  TPessEdBasForm = class(TEdBasForm)
    NomePessLabel: TLabel;
    NomePessEdit: TEdit;
    NomeFantaPessLabel: TLabel;
    NomeFantaPessEdit: TEdit;
    Label1: TLabel;
    ApelidoPessEdit: TEdit;
    CPessLabel: TLabel;
    CPessEdit: TEdit;
    IPessLabel: TLabel;
    Edit1: TEdit;
    MPessLabel: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label3: TLabel;
    EnderecoPanel: TPanel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure NomePessEditKeyPress(Sender: TObject; var Key: Char);
    procedure NomePessEditChange(Sender: TObject);
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;

    FEnderFrame: TEnderFrame;

    procedure PreenchaControles;
  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PessEdBasForm: TPessEdBasForm;

implementation

{$R *.dfm}

uses App.Pess.Ent.Factory_u, Sis.UI.Controls.TLabeledEdit;

procedure TPessEdBasForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sDes: string;
begin
  inherited;
  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sNom := FPessEnt.NomeEnt;
        sDes := FPessEnt.Nome;

        sFormat := 'Alterando %s: %s';
        sCaption := Format(sFormat, [sNom, sDes]);
      end;

    dsInsert:
      ;
  end;
end;

function TPessEdBasForm.ControlesOk: boolean;
begin
  Result := TesteEditVazio(NomePessEdit, 'Nome', ErroOutput);
  if not Result then
    exit;

end;

procedure TPessEdBasForm.ControlesToEnt;
begin
  inherited;
  NomePessEdit.Text := FPessEnt.Nome;
end;

constructor TPessEdBasForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited;
  FPessEnt := EntEdCastToPessEnt(pEntEd);
  FPessDBI := EntDBICastToPessDBI(pEntDBI);

  FEnderFrame := TEnderFrame.Create(EnderecoPanel, FPessEnt, FPessDBI, pAppInfo);
end;

function TPessEdBasForm.DadosOk: boolean;
begin

end;

procedure TPessEdBasForm.EntToControles;
begin
  inherited;
  FPessEnt.Nome := NomePessEdit.Text;
end;

function TPessEdBasForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sId, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := EntEd.NomeEnt;
  sVal := FPessEnt.Nome;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sVal]);
end;

function TPessEdBasForm.GravouOk: boolean;
begin

end;

procedure TPessEdBasForm.NomePessEditChange(Sender: TObject);
begin
  inherited;
  MensLimpar;
end;

procedure TPessEdBasForm.NomePessEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    //AtivoCheckBox.SetFocus;
    exit;
  end;
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.PreenchaControles;
begin

end;

procedure TPessEdBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  NomePessEdit.SetFocus;
end;

end.
