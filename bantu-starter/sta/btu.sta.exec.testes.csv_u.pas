unit btu.sta.exec.testes.csv_u;

interface

procedure Ler;

implementation

uses System.Classes, System.SysUtils;

// Definindo o record TUfMunRecord
type
  TUfMunRecord = record
    UfId: smallint;
    UfNome: string;
    MunId: integer;
    MunNome: string;
  end;

procedure Ler;
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
  Stream := TFileStream.Create('D:\Doc\sefaz\DTB_2022\MUNICIPIOs.csv', fmOpenRead);
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

      // Voltando ao início do arquivo
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

end.
