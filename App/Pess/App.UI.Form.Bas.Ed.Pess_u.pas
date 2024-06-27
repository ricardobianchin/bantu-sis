unit App.UI.Form.Bas.Ed.Pess_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Buttons, App.Ent.Ed, App.Ent.DBI, App.AppInfo, App.Pess.Ent,
  App.Pess.DBI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, App.Pess.Ender.Frame_u,
  Vcl.ComCtrls;

type
  TPessEdBasForm = class(TEdBasForm)
    NomePessLabel: TLabel;
    NomePessEdit: TEdit;
    NomeFantaPessLabel: TLabel;
    NomeFantaPessEdit: TEdit;
    ApelidoPessLabel: TLabel;
    ApelidoPessEdit: TEdit;
    CPessLabel: TLabel;
    CPessEdit: TEdit;
    IPessLabel: TLabel;
    IPessEdit: TEdit;
    MPessLabel: TLabel;
    MPessEditEdit: TEdit;
    MUFPessLabel: TLabel;
    MUFPessEdit: TEdit;
    EMailPessLabel: TLabel;
    EMailPessEdit: TEdit;
    DtNascPessLabel: TLabel;
    DtNascDateTimePicker: TDateTimePicker;
    EnderecoPanel: TPanel;
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure NomePessEditKeyPress(Sender: TObject; var Key: Char);
    procedure NomeFantaPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure ApelidoPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure CPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure IPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure MPessEditEditKeyPress(Sender: TObject; var Key: Char);
    procedure MUFPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure EMailPessEditKeyPress(Sender: TObject; var Key: Char);
    procedure DtNascDateTimePickerKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;

    FEnderFrame: TEnderFrame;

  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
    procedure AjusteTabOrder; virtual;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppInfo: IAppInfo; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PessEdBasForm: TPessEdBasForm;

implementation

{$R *.dfm}

uses App.Pess.Ent.Factory_u, Sis.UI.Controls.TLabeledEdit, Sis.Types.Dates, Sis.UI.Controls.Utils;


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
  FEnderFrame.AjusteControles;
  NomePessEdit.SetFocus;
  AjusteTabOrder;

  NomePessEdit.OnKeyPress :=          NomePessEditKeyPress;
  NomeFantaPessEdit.OnKeyPress :=     NomeFantaPessEditKeyPress;
  ApelidoPessEdit.OnKeyPress :=       ApelidoPessEditKeyPress;
  CPessEdit.OnKeyPress :=             CPessEditKeyPress;
  IPessEdit.OnKeyPress :=             IPessEditKeyPress;
  MPessEditEdit.OnKeyPress :=         MPessEditEditKeyPress;
  MUFPessEdit.OnKeyPress :=           MUFPessEditKeyPress;
  EMailPessEdit.OnKeyPress :=         EMailPessEditKeyPress;
  DtNascDateTimePicker.OnKeyPress :=  DtNascDateTimePickerKeyPress;
end;

procedure TPessEdBasForm.AjusteTabOrder;
begin
  NomePessEdit.TabOrder := 0;
  NomeFantaPessEdit.TabOrder := 1;
  ApelidoPessEdit.TabOrder := 2;
  CPessEdit.TabOrder := 3;
  IPessEdit.TabOrder := 4;
  MPessEditEdit.TabOrder := 5;
  MUFPessEdit.TabOrder := 6;
  EMailPessEdit.TabOrder := 7;
  DtNascDateTimePicker.TabOrder := 8;
end;

procedure TPessEdBasForm.ApelidoPessEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
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
  FPessEnt.Nome := NomePessEdit.Text;
  FPessEnt.NomeFantasia := NomeFantaPessEdit.Text;
  FPessEnt.Apelido := ApelidoPessEdit.Text;
  FPessEnt.C := CPessEdit.Text;
  FPessEnt.I := IPessEdit.Text;
  FPessEnt.M := MPessEditEdit.Text;
  FPessEnt.MUF := MUFPessEdit.Text;
  FPessEnt.EMail := EMailPessEdit.Text;

  FPessEnt.DtNasc := DtNascDateTimePicker.Date;

  FEnderFrame.ControlesToEnt;
end;

procedure TPessEdBasForm.CPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

constructor TPessEdBasForm.Create(AOwner: TComponent; pAppInfo: IAppInfo;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited;
  FPessEnt := EntEdCastToPessEnt(pEntEd);
  FPessDBI := EntDBICastToPessDBI(pEntDBI);

  FEnderFrame := TEnderFrame.Create(EnderecoPanel, FPessEnt, FPessDBI, pAppInfo,
    OkAct_DiagExecute);

  DtNascDateTimePicker.Time := 0;
  DtNascDateTimePicker.Date := Date;

end;

function TPessEdBasForm.DadosOk: boolean;
begin
  Result := FEnderFrame.DadosOk;
end;

procedure TPessEdBasForm.DtNascDateTimePickerKeyPress(Sender: TObject;
  var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
//  FEnderFrame.FoqueOPrimeiro;
end;

procedure TPessEdBasForm.EMailPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.EntToControles;
begin
  inherited;
  NomePessEdit.Text := FPessEnt.Nome;
  NomeFantaPessEdit.Text := FPessEnt.NomeFantasia;
  ApelidoPessEdit.Text := FPessEnt.Apelido;
  CPessEdit.Text := FPessEnt.C;
  IPessEdit.Text := FPessEnt.I;
  MPessEditEdit.Text := FPessEnt.M;
  MUFPessEdit.Text := FPessEnt.MUF;
  EMailPessEdit.Text := FPessEnt.EMail;
  DtNascDateTimePicker.Date := GetValidDate(FPessEnt.DtNasc);

  FEnderFrame.EntToControles;
end;

procedure TPessEdBasForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
//
end;

procedure TPessEdBasForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//
end;

function TPessEdBasForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sId, sVal: string;
begin
  sTit := EntEd.StateAsTitulo;
  sNom := EntEd.NomeEnt;
  if EntEd.State = dsInsert then
    sVal := ''
  else
    sVal := FPessEnt.CodAsString;

  sFormat := '%s %s: %s';
  Result := Format(sFormat, [sTit, sNom, sVal]);
end;

function TPessEdBasForm.GravouOk: boolean;
begin
  Result := EntDBI.Gravar;
end;

procedure TPessEdBasForm.IPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.MPessEditEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.MUFPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.NomeFantaPessEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.NomePessEditKeyPress(Sender: TObject; var Key: Char);
begin
  //inherited;
  EditKeyPress(Sender, Key);
  if key = #13 then
    NomeFantaPessEdit.SetFocus;
//SelectNext(NomePessEdit,True, True);
end;

procedure TPessEdBasForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  NomePessEdit.SetFocus;
  SetTabOrderToHint(Self)
end;

end.
