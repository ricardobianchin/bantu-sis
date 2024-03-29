unit IbgeMunImportForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, comobj;

type
  TForm2 = class(TForm)
    ArqLabeledEdit: TLabeledEdit;
    ArqSelectButton: TButton;
    OpenDialog1: TOpenDialog;
    ImportarButton: TButton;
    StatusMemo: TMemo;
    procedure ArqSelectButtonClick(Sender: TObject);
    procedure ImportarButtonClick(Sender: TObject);
    procedure ArqLabeledEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    UFSL: TStringList;
    MunSL: TStringList;
    IbgeToUfSL: TStringList;

    procedure PreencherIbgeToUfSL;
    function IbgeToUf(pIbgeCod: string): string;


    procedure ExibLog(pFrase: string);
    procedure ImportePlanilha;
    procedure ImporteCSVToArray;
    procedure ImporteCSV;

    procedure SalveSL;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses btn.lib.types.strings;

procedure TForm2.ArqLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    ImportarButton.Click;
end;

procedure TForm2.ArqSelectButtonClick(Sender: TObject);
begin
  if not OpenDialog1.Execute then
    exit;
  ArqLabeledEdit.Text := OpenDialog1.FileName;
end;

procedure TForm2.ExibLog(pFrase: string);
begin
  StatusMemo.Lines.Add(pFrase);
  SendMessage(StatusMemo.Handle, EM_LINESCROLL, 0, StatusMemo.Lines.Count);
  Application.ProcessMessages;
end;

function TForm2.IbgeToUf(pIbgeCod: string): string;
begin
  Result := IbgeToUfSL.Values[pIbgeCod];
end;

procedure TForm2.ImportarButtonClick(Sender: TObject);
begin
  ExibLog('ini');
  try
    ImporteCSV;
    Close;
  finally
    ExibLog('fim');
  end;
end;

procedure TForm2.ImporteCSV;
var
  Stream: TFileStream;
  Reader: TStreamReader;
  Line: string;
  aCampos: TArray<string>;
  i: integer;
  s: string;
  sUFSigla, sMunId, sMunNome: string;
//  UF_SIGLA;Mun_ID;Mun_Nome
begin
  // Abrindo o arquivo
  Stream := TFileStream.Create(ArqLabeledEdit.Text, fmOpenRead);
  UFSL := TStringList.Create;
  MunSL := TStringList.Create;
  UFSL.Sorted := True;
  UFSL.Duplicates := dupIgnore;

  IbgeToUfSL := TStringList.Create;
  PreencherIbgeToUfSL;

  try
    // Criando o leitor de texto
    Reader := TStreamReader.Create(Stream, TEncoding.ANSI, false);
    try
      // Descartando a primeira linha
      Reader.ReadLine;

      // Lendo as linhas e preenchendo o array
      while not Reader.EndOfStream do
      begin
        Line := Reader.ReadLine;
        Line := StrSemAcento(StrSemEspacoDuplo(Line));

        // Separando os campos por ;
        aCampos := Line.Split([';']);

        sUFSigla := IbgeToUf(aCampos[0]);
        sMunId := aCampos[2];
        Delete(sMunId, 1, 2);
        sMunNome := aCampos[3];

        s := aCampos[0] + ';' + aCampos[1];
        UFSL.Add(s);

        s := sUFSigla + ';' + sMunId + ';' + sMunNome;
        MunSL.Add(s)
      end;
    finally
      Reader.Free;
    end;
    SalveSL;
  finally
    Stream.Free;
    UFSL.Free;
    MunSL.Free;
    IbgeToUfSL.Free;
  end;
end;

procedure TForm2.ImporteCSVToArray;
// Definindo o record TUfMunRecord
type
  TUfMunRecord = record
    UfId: smallint;
    UfNome: string;
    MunId: integer;
    MunNome: string;
  end;

// Definindo o array UfMunArray
var
  UfMunArray: array of TUfMunRecord;

// Lendo o arquivo usando stream
var
  Stream: TFileStream;
  Reader: TStreamReader;
  Line: string;
  LineCount: integer;
  Fields: TArray<string>;
  i: integer;
begin
  // Abrindo o arquivo
  Stream := TFileStream.Create(ArqLabeledEdit.Text, fmOpenRead);
  try
    // Criando o leitor de texto
    Reader := TStreamReader.Create(Stream);
    try
      // Descartando a primeira linha
      Reader.ReadLine;

      // Contando as linhas restantes
      LineCount := 0;
      while not Reader.EndOfStream do
      begin
        Reader.ReadLine;
        Inc(LineCount);
      end;

      // Ajustando o tamanho do array
      SetLength(UfMunArray, LineCount);

      // Voltando ao in�cio do arquivo
      Reader.DiscardBufferedData;
      Stream.Position := 0;

      // Descartando a primeira linha novamente
      Reader.ReadLine;

      // Lendo as linhas e preenchendo o array
      i := 0;
      while not Reader.EndOfStream do
      begin
        Line := Reader.ReadLine;

        // Separando os campos por ;
        Fields := Line.Split([';']);

        // Atribuindo os valores aos campos do record
        UfMunArray[i].UfId := StrToInt(Fields[0]);
        UfMunArray[i].UfNome := Fields[1];
        UfMunArray[i].MunId := StrToInt(Fields[2]);
        UfMunArray[i].MunNome := Fields[3];

        Inc(i);
      end;
    finally
      Reader.Free;
    end;
  finally
    Stream.Free;
  end;
end;

procedure TForm2.ImportePlanilha;
const
   xlCellTypeLastCell = $0000000B;
var
   XLSAplicacao, AbaXLS: OLEVariant;
   RangeMatrix: Variant;
   x, y, k, r: Integer;
begin
(*
���Result := False;
���// Cria Excel- OLE Object
���XLSAplicacao := CreateOleObject('Excel.Application');
���try
���// Esconde Excel
������XLSAplicacao.Visible := False;
������// Abre o Workbook
������XLSAplicacao.Workbooks.Open(xFileXLS);
�
������{Selecione aqui a aba que voc� deseja abrir primeiro - 1,2,3,4....}
������XLSAplicacao.WorkSheets[1].Activate;
������{Selecione aqui a aba que voc� deseja ativar - come�ando sempre no 1 (1,2,3,4) }
������AbaXLS := XLSAplicacao.Workbooks[ExtractFileName(xFileXLS)].WorkSheets[1];
�
������AbaXLS.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
������// Pegar o n�mero da �ltima linha
������x := XLSAplicacao.ActiveCell.Row;
������// Pegar o n�mero da �ltima coluna
������y := XLSAplicacao.ActiveCell.Column;
������// Seta xStringGrid linha e coluna
������XStringGrid.RowCount := x;
������XStringGrid.ColCount := y;
������// Associaca a variant WorkSheet com a variant do Delphi
������RangeMatrix := XLSAplicacao.Range['A1', XLSAplicacao.Cells.Item[x, y]].Value;
������// Cria o loop para listar os registros no TStringGrid
������k := 1;
������repeat
���������for r := 1 to y do
������������XStringGrid.Cells[(r - 1), (k - 1)] := RangeMatrix[k, r];
���������Inc(k, 1);
������until k > x;
������RangeMatrix := Unassigned;
������finally
������������// Fecha o Microsoft Excel
������������if not VarIsEmpty(XLSAplicacao) then
������������begin
������������������XLSAplicacao.Quit;
������������������XLSAplicacao := Unassigned;
������������������AbaXLS := Unassigned;
������������������Result := True;
������������end;
������end;
*)
end;

procedure TForm2.PreencherIbgeToUfSL;
begin
  IbgeToUfSL.Text:=
    '11=RO'#13#10+
    '12=AC'#13#10+
    '13=AM'#13#10+
    '14=RR'#13#10+
    '15=PA'#13#10+
    '16=AP'#13#10+
    '17=TO'#13#10+
    '21=MA'#13#10+
    '22=PI'#13#10+
    '23=CE'#13#10+
    '24=RN'#13#10+
    '25=PR'#13#10+
    '26=PE'#13#10+
    '27=AL'#13#10+
    '28=SE'#13#10+
    '29=BA'#13#10+
    '31=MG'#13#10+
    '32=ES'#13#10+
    '33=RJ'#13#10+
    '35=SP'#13#10+
    '41=PR'#13#10+
    '42=SC'#13#10+
    '43=RS'#13#10+
    '50=MS'#13#10+
    '51=MT'#13#10+
    '52=GO'#13#10+
    '53=DF'#13#10
    ;
end;

procedure TForm2.SalveSL;
var
  sPasta: string;
begin
  sPasta := IncludeTrailingPathDelimiter( ExtractFilePath(ArqLabeledEdit.Text));

//  UFSL.SaveToFile(sPasta + 'uf.csv');
  MunSL.SaveToFile(sPasta + 'mun.csv');
end;

end.
