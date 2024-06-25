unit App.Pess.Ender.Controls.Frame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Frame.Bas_u, App.Pess.Ent, App.Pess.DBI, Data.DB, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.StdCtrls, Sis.UI.Controls.Utils,
  Sis.UI.Controls.ComboBox.Frame_u, App.PessEnder, Sis.Types.Integers;

type
  TEnderControlsFrame = class(TBasFrame)
    LogradouroLabel: TLabel;
    LogradouroEdit: TEdit;
    TopoPanel: TPanel;
    EnderStatusLabel: TLabel;
    NumeroLabel: TLabel;
    NumeroEdit: TEdit;
    ComplementoLabel: TLabel;
    ComplementoEdit: TEdit;
    BairroLabel: TLabel;
    BairroEdit: TEdit;
    CEPLabel: TLabel;
    CEPEdit: TEdit;
    MunicipioSubPanel: TPanel;
    UFSiglaSubPanel: TPanel;
    DDDLabel: TLabel;
    DDDEdit: TEdit;
    TelefonesLabel: TLabel;
    Fone1Edit: TEdit;
    Fone2Edit: TEdit;
    Fone3Edit: TEdit;
    ContatoLabel: TLabel;
    ContatoEdit: TEdit;
    ReferenciaLabel: TLabel;
    ReferenciaMemo: TMemo;
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;
    FFDMemTable: TFDMemTable;

    UFComboFrame: TComboBoxBasFrame;
    MunicipioComboFrame: TComboBoxBasFrame;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPessEnt: IPessEnt;
      pPessDBI: IPessDBI; pEnderPessFDMemTable: TFDMemTable); reintroduce;
    procedure AjusteControles;
    procedure ControlesToEnt;
    procedure EntToControles;
  end;

var
  EnderControlsFrame: TEnderControlsFrame;

implementation

{$R *.dfm}
{ TEnderControlsFrame }

procedure TEnderControlsFrame.ControlesToEnt;
var
  Tab: TFDMemTable;
begin
  inherited;
  Tab := FFDMemTable;

  Tab.Fields[7 {CEP}].AsString := CEPEdit.Text;
  Tab.Fields[6 {UF_SIGLA}].AsString := UFComboFrame.Text;

  Tab.Fields[5 {MUNICIPIO_NOME}].AsString := MunicipioComboFrame.Text;
  Tab.Fields[14 {MUNICIPIO_IBGE_ID}].AsString := IntToStrZero( MunicipioComboFrame.Id, 5);

  Tab.Fields[4 {BAIRRO}].AsString := BairroEdit.Text;
  Tab.Fields[1 {LOGRADOURO}].AsString := LogradouroEdit.Text;
  Tab.Fields[2 {NUMERO}].AsString := NumeroEdit.Text;
  Tab.Fields[3 {COMPLEMENTO}].AsString := ComplementoEdit.Text;
  Tab.Fields[8 {DDD}].AsString := DDDEdit.Text;
  Tab.Fields[9 {FONE1}].AsString := Fone1Edit.Text;
  Tab.Fields[10 {FONE2}].AsString := Fone2Edit.Text;
  Tab.Fields[11 {FONE3}].AsString := Fone3Edit.Text;
  Tab.Fields[12 {CONTATO}].AsString := ContatoEdit.Text;
  Tab.Fields[13 {REFERENCIA}].AsString := ReferenciaMemo.Lines.Text;
end;

constructor TEnderControlsFrame.Create(AOwner: TComponent; pPessEnt: IPessEnt;
  pPessDBI: IPessDBI; pEnderPessFDMemTable: TFDMemTable);
begin
  inherited Create(AOwner);
  FPessEnt := pPessEnt;
  FPessDBI := pPessDBI;
  FFDMemTable := pEnderPessFDMemTable;
  UFComboFrame := TComboBoxBasFrame.Create(Self);
  MunicipioComboFrame := TComboBoxBasFrame.Create(Self);
end;

procedure TEnderControlsFrame.EntToControles;
var
  Tab: TFDMemTable;
  iId: integer;
begin
  inherited;
  Tab := FFDMemTable;

  CEPEdit.Text := Tab.Fields[7 {CEP}].AsString;
  UFComboFrame.PosicionePeloTexto(Tab.Fields[6 {UF_SIGLA}].AsString);

  iId := Tab.Fields[14 {MUNICIPIO_IBGE_ID}].AsInteger;
  MunicipioComboFrame.Id := iId;

  BairroEdit.Text := Tab.Fields[4 {BAIRRO}].AsString;
  LogradouroEdit.Text := Tab.Fields[1 {LOGRADOURO}].AsString;
  NumeroEdit.Text := Tab.Fields[2 {NUMERO}].AsString;
  ComplementoEdit.Text := Tab.Fields[3 {COMPLEMENTO}].AsString;
  DDDEdit.Text := Tab.Fields[8 {DDD}].AsString;
  Fone1Edit.Text := Tab.Fields[9 {FONE1}].AsString;
  Fone2Edit.Text := Tab.Fields[10 {FONE2}].AsString;
  Fone3Edit.Text := Tab.Fields[11 {FONE3}].AsString;
  ContatoEdit.Text := Tab.Fields[12 {CONTATO}].AsString;
  ReferenciaMemo.Lines.Text := Tab.Fields[13 {REFERENCIA}].AsString;
end;

procedure TEnderControlsFrame.AjusteControles;
begin
  PegueFormatoDe(MunicipioComboFrame, MunicipioSubPanel);
  PegueFormatoDe(UFComboFrame, UFSiglaSubPanel);
end;

end.
