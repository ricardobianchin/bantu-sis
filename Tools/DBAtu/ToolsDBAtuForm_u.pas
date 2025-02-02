unit ToolsDBAtuForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, ToolsDBAtu.Config, Sis.UI.IO.Output;

type
  TToolsDBAtuForm = class(TBasForm)
    StatusMemo: TMemo;
    BancosListBox: TListBox;
    ApresLabel: TLabel;
    ExecutarButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ExecutarButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FPastaBin, FPasta, FPastaDados: string;
    FToolsDBAtuConfig: IToolsDBAtuConfig;
    FStatusOutput: IOutput;
    FEnumValuesSL: TStringList;
    procedure PegarPastas;
    procedure PreencherBancosListBox;
    procedure CarregarConfig;
    procedure Executar;
    procedure PegarEnumValues;
    procedure ApaguePrefixos;
    procedure AcrescenteIds;
    procedure AtualizarArqTxtDBUpdate;
    procedure AtualizarArqPasTerminalEd;
    procedure SLUpdateCSVContent(pSL: TStrings; const pTitulo, pFim: string;
      const pNovoConteudo: TStrings);
  public
    { Public declarations }
  end;

var
  ToolsDBAtuForm: TToolsDBAtuForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, ToolsDBAtu.Factory_u, Sis.Config.ConfigXMLI,
  Sis.UI.IO.Factory, Sis.UI.IO.Files.PasI, Sis.Types.TStrings_u;

{ TToolsDBAtuForm }

procedure TToolsDBAtuForm.AcrescenteIds;
var
  i: integer;
begin
  for i := 0 to FEnumValuesSL.Count - 1 do
  begin
    FEnumValuesSL[i] := i.ToString + ';' + FEnumValuesSL[i];
  end;
end;

procedure TToolsDBAtuForm.ApaguePrefixos;
begin
  SLApaguePrefixos(FEnumValuesSL);
  FStatusOutput.Exibir('---'#13#10 + FEnumValuesSL.Text + '----');
end;

procedure TToolsDBAtuForm.AtualizarArqPasTerminalEd;
const
  INI = '//BalComboBox add ini';
  FIM = '//BalComboBox add fim';
  ARQ = 'C:\Pr\app\bantu\bantu-sis\Src\App\Modulos\Config\Ambi\Terminal\App.UI.Form.Config.Ambi.Terminal.Ed_u.pas';
var
  i: integer;
  iIni: integer;
  iFin: integer;
  iQtdLinsApagar: integer;
  Linhas, NovoConteudo: TStringList;
begin
  Linhas := TStringList.Create;
  try
    Linhas.LoadFromFile(ARQ);
    iIni := SLNLinhaQTem(Linhas, INI);
    iFin := SLNLinhaQTem(Linhas, FIM);
    iQtdLinsApagar := (iFin - iIni) - 1;
    inc(iIni);
    for i := 1 to iQtdLinsApagar do
    begin
      Linhas.Delete(iIni);
    end;
    for i := FEnumValuesSL.Count - 1 to 0 do
    begin
      Linhas.Insert(iIni, FEnumValuesSL[i] );
    end;
    Linhas.SaveToFile(ARQ);
  finally
    Linhas.Free;
  end;
end;

procedure TToolsDBAtuForm.AtualizarArqTxtDBUpdate;
const
  INI = 'BALANCA_ID;MODELO';
  FIM = 'CSV FIM';
  ARQ = 'C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates\000\00\00\00\dbupdate 000000009.txt';
var
  Linhas, NovoConteudo: TStringList;
begin
  Linhas := TStringList.Create;
  NovoConteudo := TStringList.Create;
  try
    Linhas.LoadFromFile(ARQ);
    NovoConteudo.Assign(FEnumValuesSL);
    SLUpdateCSVContent(Linhas, INI, FIM, NovoConteudo);
    Linhas.SaveToFile(ARQ);
  finally
    Linhas.Free;
    NovoConteudo.Free;
  end;
end;

procedure TToolsDBAtuForm.CarregarConfig;
var
  oToolsDBAtuConfigXMLI: IConfigXMLI;
begin
  FStatusOutput.Exibir('Carregar config');
  FToolsDBAtuConfig := ToolsDBAtuConfigCreate;
  oToolsDBAtuConfigXMLI := ToolsDBAtuConfigXMLICreate(FToolsDBAtuConfig);
  oToolsDBAtuConfigXMLI.Ler;
  FStatusOutput.Exibir('.pas com type bal = ' +
    FToolsDBAtuConfig.ArqTypeBalancaPas);
end;

procedure TToolsDBAtuForm.Executar;
begin
  FStatusOutput.Exibir('Executar ini');
  try
    PegarEnumValues;
    ApaguePrefixos;
    SLUpperCase(FEnumValuesSL);
    FEnumValuesSL[0] := 'NAO INDICADO';
    AcrescenteIds;
    AtualizarArqTxtDBUpdate;
    AtualizarArqPasTerminalEd;
  finally
    FStatusOutput.Exibir('Executar fim');
  end;
end;

procedure TToolsDBAtuForm.ExecutarButtonClick(Sender: TObject);
begin
  inherited;
  Executar;
  Close;
end;

procedure TToolsDBAtuForm.FormCreate(Sender: TObject);
begin
  inherited;
  FStatusOutput := MemoOutputCreate(StatusMemo);
  FEnumValuesSL := TStringList.Create;

  PegarPastas;
  PreencherBancosListBox;
  CarregarConfig;
end;

procedure TToolsDBAtuForm.FormDestroy(Sender: TObject);
begin
  FEnumValuesSL.Free;
  inherited;
end;

procedure TToolsDBAtuForm.PegarEnumValues;
begin
  PreenchaEnumValues(FToolsDBAtuConfig.ArqTypeBalancaPas, 'TACBrBALModelo',
    FEnumValuesSL);
  FStatusOutput.Exibir('---'#13#10 + FEnumValuesSL.Text + '----');

end;

procedure TToolsDBAtuForm.PegarPastas;
begin
  FPastaBin := GetPastaDoArquivo(ParamStr(0));
  FPasta := PastaAcima(FPasta);
  FPastaDados := FPasta + 'Dados\';
  FStatusOutput.Exibir('Pasta dados = ' + FPastaDados);
end;

procedure TToolsDBAtuForm.PreencherBancosListBox;
begin
  FStatusOutput.Exibir('Preencher Bancos ListBox');
  LeDiretorio(FPastaDados, BancosListBox.Items, True, 'DADOS_*.FDB');
end;

procedure TToolsDBAtuForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  ExecutarButton.Click;
end;

procedure TToolsDBAtuForm.SLUpdateCSVContent(pSL: TStrings;
  const pTitulo, pFim: string; const pNovoConteudo: TStrings);
var
  i, idxInicio, idxFim: integer;
begin
  idxInicio := SLNLinhaQTem(pSL, pTitulo);
  if idxInicio = -1 then
    Exit;
  Inc(idxInicio, 2);

  idxFim := SLNLinhaQTem(pSL, pFim, idxInicio);
  if idxFim = -1 then
    Exit;

  for i := idxFim - 1 downto idxInicio do
    pSL.Delete(i);

  for i := 0 to pNovoConteudo.Count - 1 do
    pSL.Insert(idxInicio + i, pNovoConteudo[i]);

  pSL.Insert(idxInicio + pNovoConteudo.Count, '');
end;

end.
