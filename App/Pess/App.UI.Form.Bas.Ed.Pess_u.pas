unit App.UI.Form.Bas.Ed.Pess_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Buttons, App.Ent.Ed, App.Ent.DBI, App.AppObj, App.Pess.Ent,
  App.Pess.DBI, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, App.Pess.Ender.Frame_u,
  Vcl.ComCtrls, App.Pess.Utils, Vcl.Mask;

type
  TPessEdBasForm = class(TEdBasForm)
    EnderecoPanel: TPanel;
    TitPanel: TPanel;
    NomePanel: TPanel;
    NomePessEdit: TEdit;
    NomePessLabel: TLabel;
    PesJurPanel: TPanel;
    NomeFantaPessLabel: TLabel;
    NomeFantaPessEdit: TEdit;
    ApelidoPessLabel: TLabel;
    ApelidoPessEdit: TEdit;
    DocsPanel: TPanel;
    CPessEdit: TEdit;
    IPessEdit: TEdit;
    MPessEditEdit: TEdit;
    MUFPessLabel: TLabel;
    MPessLabel: TLabel;
    AtivoPessCheckBox: TCheckBox;
    DtNascPessLabel: TLabel;
    EMailPessEdit: TEdit;
    EMailPessLabel: TLabel;
    DtNascMaskEdit: TMaskEdit;
    CPessLabel: TLabel;
    IPessLabel: TLabel;
    Button1: TButton;
    Button2: TButton;
    MUFPessComboBox: TComboBox;
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
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CPessEditExit(Sender: TObject);
    procedure AtivoPessCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure CPessEditChange(Sender: TObject);
    procedure MUFPessComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CPessEditKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FPessEnt: IPessEnt;
    FPessDBI: IPessDBI;

    FEnderFrame: TEnderFrame;

    function NomeOk: boolean;
    function COk: boolean;
    function DtNascOk: boolean;

    procedure ColarC;
    procedure AjusteCamposPess;
    procedure PreenchaMUFPessComboBox;

  protected
    function GetObjetivoStr: string; override;
    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
    procedure AjusteTabOrder; virtual;

    function NomeFantasiaOk: boolean; virtual;
    function ApelidoOk: boolean; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI); override;
  end;

var
  PessEdBasForm: TPessEdBasForm;

implementation

{$R *.dfm}

uses App.Pess.Ent.Factory_u, Sis.UI.Controls.TLabeledEdit, Sis.Types.Dates,
  Sis.UI.Controls.Utils, Sis.Types.Codigos.Utils, Sis.DB.DBTypes, Sis.Types,
  Sis.Types.strings_u, Sis.Win.Utils_u, System.StrUtils, Sis.Types.Utils_u,
  Sis.Sis.Constants;

procedure TPessEdBasForm.AjusteCamposPess;
begin
  if CPFValido(CPessEdit.Text) then
  begin
    MUFPessComboBox.Visible := True;
    MUFPessLabel.Visible := True;
    MPessLabel.Caption := 'Órgão Emissor';
    IPessLabel.Caption := 'Identidade';
  end
  else
  begin
    MUFPessComboBox.Visible := False;
    MUFPessLabel.Visible := False;
    MPessLabel.Caption := 'Inscr.Mun.';
    IPessLabel.Caption := 'Inscr.Est.';
  end;

  {
    object MPessLabel: TLabel
    Left = 475
    Top = 4
    Width = 56
    Height = 15
    Caption = 'Inscr.Mun.'
    FocusControl = MPessEditEdit
    end
    object IPessLabel: TLabel
    Left = 237
    Top = 4
    Width = 64
    Height = 15
    Caption = 'Id./Inscr.Est.'
    end


  }

end;

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

  NomePessEdit.OnKeyPress := NomePessEditKeyPress;
  NomeFantaPessEdit.OnKeyPress := NomeFantaPessEditKeyPress;
  ApelidoPessEdit.OnKeyPress := ApelidoPessEditKeyPress;
  CPessEdit.OnKeyPress := CPessEditKeyPress;
  IPessEdit.OnKeyPress := IPessEditKeyPress;
  MPessEditEdit.OnKeyPress := MPessEditEditKeyPress;
  // MUFPessEdit.OnKeyPress := MUFPessEditKeyPress;
  EMailPessEdit.OnKeyPress := EMailPessEditKeyPress;
  DtNascMaskEdit.OnKeyPress := DtNascDateTimePickerKeyPress;
  AtivoPessCheckBox.OnKeyPress := AtivoPessCheckBoxKeyPress;
end;

procedure TPessEdBasForm.AjusteTabOrder;
begin
  NomePessEdit.TabOrder := 0;
  NomeFantaPessEdit.TabOrder := 1;
  ApelidoPessEdit.TabOrder := 2;
  CPessEdit.TabOrder := 3;
  IPessEdit.TabOrder := 4;
  MPessEditEdit.TabOrder := 5;
  MUFPessComboBox.TabOrder := 6;
  EMailPessEdit.TabOrder := 7;
  DtNascMaskEdit.TabOrder := 8;
  AtivoPessCheckBox.TabOrder := 9;
end;

procedure TPessEdBasForm.ApelidoPessEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.AtivoPessCheckBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  CheckBoxKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.Button1Click(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := CNPJGetRandom;
  CPessEdit.Text := s;
  IPessEdit.SetFocus;
  // function CPFGetRandom: string;
end;

procedure TPessEdBasForm.Button2Click(Sender: TObject);
var
  s: string;
begin
  inherited;
  s := CPFGetRandom;
  CPessEdit.Text := s;
  IPessEdit.SetFocus;
end;

function TPessEdBasForm.COk: boolean;
var
  sMens: string;

  iEncontradoLojaId: smallint; //
  iEncontradoTerminalId: smallint; //
  iEncontradoPessoaId: integer; //
  sEncontradoNome: string; //

  bEncontrado: boolean;
  sC: string;
begin
  CPessEdit.Text := Trim(CPessEdit.Text);
  sC := CPessEdit.Text;

  try
    if sC = '' then
    begin
      Result := not FPessEnt.CObrigatorio;
      if Result then
        exit;

      sMens := CPessLabel.Caption + ' é obrigatório';
    end
    else
    begin
      Result := Sis.Types.Codigos.Utils.CValido(sC);
      if not Result then
      begin
        sMens := CPessLabel.Caption + ' inválido';
        if not FPessEnt.CObrigatorio then
          sMens := sMens + '. Corrija o campo ou deixe-o vazio';
        exit;
      end;

      FPessDBI.CToPess(sC, //
        bEncontrado, //

        iEncontradoLojaId, //
        iEncontradoTerminalId, //
        iEncontradoPessoaId, //
        sEncontradoNome, //

        FPessEnt.LojaId, //
        FPessEnt.TerminalId, //
        FPessEnt.Id); //

      Result := not bEncontrado;

      if not Result then
      begin
        sMens := 'Já existe um registro com este ' + string(CPessLabel.Caption)
          +': '+ CodsToCodAsString(iEncontradoLojaId, iEncontradoTerminalId,
          iEncontradoPessoaId, FPessEnt.CodUsaTerminalId) + ' - ' +
          sEncontradoNome;
      end;
    end;
  finally
    if not Result then
    begin
      ErroOutput.Exibir(sMens);
      CPessEdit.SetFocus;
    end;
  end;
end;

procedure TPessEdBasForm.ColarC;
var
  sText: string;
begin
  inherited;
  sText := GetClipboardText;
  sText := StrToOnlyDigit(sText);

  if sText = '' then
    exit;

  sText := LeftStr(sText, 14);
  CPessEdit.Text := sText;
end;

function TPessEdBasForm.ControlesOk: boolean;
begin
  Result := TesteEditVazio(NomePessEdit, 'Nome', ErroOutput);
  if not Result then
    exit;

end;

procedure TPessEdBasForm.ControlesToEnt;
var
  sDigitado: string;
  dtDigitado: TDateTime;
begin
  inherited;
  FPessEnt.Nome := NomePessEdit.Text;
  FPessEnt.NomeFantasia := NomeFantaPessEdit.Text;
  FPessEnt.Apelido := ApelidoPessEdit.Text;
  FPessEnt.C := CPessEdit.Text;
  FPessEnt.I := IPessEdit.Text;
  FPessEnt.M := MPessEditEdit.Text;
  FPessEnt.MUF := MUFPessComboBox.Text;
  FPessEnt.EMail := EMailPessEdit.Text;

  // le maskedit dtnasc
  sDigitado := Trim(DtNascMaskEdit.Text); // Remove espaços extras
  if TryStrToDate(sDigitado, dtDigitado) then
    FPessEnt.DtNasc := dtDigitado
  else
    FPessEnt.DtNasc := DATA_ZERADA;

  FPessEnt.Ativo := AtivoPessCheckBox.Checked;
  FEnderFrame.ControlesToEnt;
end;

procedure TPessEdBasForm.CPessEditChange(Sender: TObject);
begin
  inherited;
  AjusteCamposPess;
end;

procedure TPessEdBasForm.CPessEditExit(Sender: TObject);
begin
  inherited;
  CPessEdit.Text := StrToOnlyDigit(CPessEdit.Text);
end;

procedure TPessEdBasForm.CPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.CPessEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    ord('v'), ord('V'):
      begin
        if Shift = [ssCtrl] then
        begin
          Key := 0;
          ColarC;
        end;
      end;
  end;
end;

constructor TPessEdBasForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI);
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
  PreenchaMUFPessComboBox;
  FPessEnt := EntEdCastToPessEnt(pEntEd);
  FPessDBI := EntDBICastToPessDBI(pEntDBI);

  FEnderFrame := TEnderFrame.Create(EnderecoPanel, FPessEnt, FPessDBI, pAppObj,
    OkAct_DiagExecute, ErroOutput);

  ObjetivoLabel.Parent := TitPanel;
  ObjetivoLabel.Top := 1;

  if FPessEnt.PessTipoAceito = TPessTipoAceito.pestipacSoPessFisica then
    PesJurPanel.Visible := False;
end;

function TPessEdBasForm.DadosOk: boolean;
begin
  Result := NomeOk;
  if not Result then
    exit;

  Result := NomeFantasiaOk;
  if not Result then
    exit;

  Result := ApelidoOk;
  if not Result then
    exit;

  Result := COk;
  if not Result then
    exit;

  Result := DtNascOk;
  if not Result then
    exit;

  Result := FEnderFrame.DadosOk;
end;

procedure TPessEdBasForm.DtNascDateTimePickerKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
  // FEnderFrame.FoqueOPrimeiro;
end;

function TPessEdBasForm.DtNascOk: boolean;
const
  EDIT_VAZIO = '  /  /    ';
var
  sDigitado: string;
  dtDigitado: TDateTime;
begin
  sDigitado := DtNascMaskEdit.Text; // Remove espaços extras

  Result := sDigitado = EDIT_VAZIO;
  if Result then
    exit;

  Result := TryStrToDate(sDigitado, dtDigitado);
  if Result then
    exit;

  if not Result then
  begin
    ErroOutput.Exibir('Data inválida. Corrija ou deixe o campo em branco');
    DtNascMaskEdit.SetFocus;
    DtNascMaskEdit.SelStart := 0;
    DtNascMaskEdit.SelLength := 1;
  end;
end;

procedure TPessEdBasForm.EMailPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  // nao chama EditKeyPress( pois deixaria key uppercase
  // repete aqui o que tinha em EditKeyPress(, exceto que no fim, CharToLow
  // inherited;
  if Key = CHAR_ENTER then
  begin
    Key := CHAR_NULO;
    // if SelecionaProximo then
    SelecioneProximo;
    exit;
  end;

  CharToLow(Key);
end;

procedure TPessEdBasForm.EntToControles;
var
  I: integer;
begin
  inherited;
  NomePessEdit.Text := FPessEnt.Nome;
  NomeFantaPessEdit.Text := FPessEnt.NomeFantasia;
  ApelidoPessEdit.Text := FPessEnt.Apelido;
  CPessEdit.Text := FPessEnt.C;
  IPessEdit.Text := FPessEnt.I;
  MPessEditEdit.Text := FPessEnt.M;
  I := MUFPessComboBox.Items.IndexOf(FPessEnt.MUF);
  if I = -1 then
    I := MUFPessComboBox.Items.IndexOf('RJ');

  MUFPessComboBox.itemindex := I;
  EMailPessEdit.Text := FPessEnt.EMail;

  if FPessEnt.DtNasc < 3 then
    DtNascMaskEdit.Clear
  else
    DtNascMaskEdit.Text := FormatDateTime('dd/mm/yyyy', FPessEnt.DtNasc);

  AtivoPessCheckBox.Checked := FPessEnt.Ativo;

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

procedure TPessEdBasForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_TAB then
  begin
    if Shift = [] then
    begin
      if ActiveControl = FEnderFrame.WinControlSeguinteAoCEP then
      begin
        FEnderFrame.PesquiseCEP;
      end;
    end;
  end;
end;

function TPessEdBasForm.GetObjetivoStr: string;
var
  sFormat, sTit, sNom, sVal: string;
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
  Result := EntDBI.Garantir;
end;

procedure TPessEdBasForm.IPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.MPessEditEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.MUFPessComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);
end;

procedure TPessEdBasForm.MUFPessEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

function TPessEdBasForm.ApelidoOk: boolean;
begin
  Result := True;
end;

procedure TPessEdBasForm.NomeFantaPessEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
end;

function TPessEdBasForm.NomeFantasiaOk: boolean;
begin
  Result := True;
end;

function TPessEdBasForm.NomeOk: boolean;
begin
  NomePessEdit.Text := Trim(NomePessEdit.Text);
  Result := NomePessEdit.Text <> '';

  if Result then
    exit;

  ErroOutput.Exibir('Nome é obrigatório');
  NomePessEdit.SetFocus
end;

procedure TPessEdBasForm.NomePessEditKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  EditKeyPress(Sender, Key);
  if Key = #13 then
  begin
    if FPessEnt.PessTipoAceito = TPessTipoAceito.pestipacSoPessFisica then
      CPessEdit.SetFocus
    else
      NomeFantaPessEdit.SetFocus;
  end;
  // SelectNext(NomePessEdit,True, True);
end;

procedure TPessEdBasForm.PreenchaMUFPessComboBox;
begin
  MUFPessComboBox.Items.Clear;

  MUFPessComboBox.Items.Add('  ');
  MUFPessComboBox.Items.Add('AC');
  MUFPessComboBox.Items.Add('AL');
  MUFPessComboBox.Items.Add('AM');
  MUFPessComboBox.Items.Add('AP');
  MUFPessComboBox.Items.Add('BA');
  MUFPessComboBox.Items.Add('CE');
  MUFPessComboBox.Items.Add('DF');
  MUFPessComboBox.Items.Add('ES');
  MUFPessComboBox.Items.Add('GO');
  MUFPessComboBox.Items.Add('MA');
  MUFPessComboBox.Items.Add('MG');
  MUFPessComboBox.Items.Add('MS');
  MUFPessComboBox.Items.Add('MT');
  MUFPessComboBox.Items.Add('PA');
  MUFPessComboBox.Items.Add('PE');
  MUFPessComboBox.Items.Add('PI');
  MUFPessComboBox.Items.Add('PR');
  MUFPessComboBox.Items.Add('PR');
  MUFPessComboBox.Items.Add('RJ');
  MUFPessComboBox.Items.Add('RN');
  MUFPessComboBox.Items.Add('RO');
  MUFPessComboBox.Items.Add('RR');
  MUFPessComboBox.Items.Add('RS');
  MUFPessComboBox.Items.Add('SC');
  MUFPessComboBox.Items.Add('SE');
  MUFPessComboBox.Items.Add('SP');
  MUFPessComboBox.Items.Add('TO');
  MUFPessComboBox.itemindex := MUFPessComboBox.Items.IndexOf('RJ');

  {
    RO;RONDONIA;11
    AC;ACRE;12
    AM;AMAZONAS;13
    RR;RORAIMA;14
    PA;PARA;15
    AP;AMAPA;16
    TO;TOCANTINS;17
    MA;MARANHAO;21
    PI;PIAUI;22
    CE;CEARA;23
    RN;RIO GRANDE DO NORTE;24
    PR;PARAIBA;25
    PE;PERNAMBUCO;26
    AL;ALAGOAS;27
    SE;SERGIPE;28
    BA;BAHIA;29
    MG;MINAS GERAIS;31
    ES;ESPIRITO SANTO;32
    RJ;RIO DE JANEIRO;33
    SP;SAO PAULO;35
    PR;PARANA;41
    SC;SANTA CATARINA;42
    RS;RIO GRANDE DO SUL;43
    MS;MATO GROSSO DO SUL;50
    MT;MATO GROSSO;51
    GO;GOIAS;52
    DF;DISTRITO FEDERAL;53

  }

end;

end.
