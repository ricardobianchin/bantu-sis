unit App.DB.Import.Form_Finalizar_u;

interface

uses Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.DB.DBTypes;

procedure Finalizar(pProdFDMemTable: TFDMemTable; pDBConnection: IDBConnection);

implementation

uses System.Classes, System.SysUtils, Sis.Types.Bool_u, Sis.Types.Floats;

var
  oProdFDMemTable: TFDMemTable;
  oDBConnection: IDBConnection;
  ComandosSL: TStringList;
  iId: integer;
  bAImportar: boolean;
  sDescr: string;
  sDescrRed: string;
  uCusto: Currency;
  aPreco: TArray<Currency>;
  sBarras: string;
  aBarras: TArray<string>;
  sComando: string;

procedure LerCampos;
begin
  iId := oProdFDMemTable.Fields[0].AsInteger;
  bAImportar := oProdFDMemTable.Fields[1].AsBoolean;
  sDescr := oProdFDMemTable.Fields[5].AsString;
  sDescrRed := oProdFDMemTable.Fields[6].AsString;
  uCusto := oProdFDMemTable.Fields[10].AsCurrency;
  aPreco[0] := oProdFDMemTable.Fields[12].AsCurrency;;
  sBarras := oProdFDMemTable.Fields[14].AsString;
  aBarras := sBarras.Split([',']);
end;

procedure Finalizar(pProdFDMemTable: TFDMemTable; pDBConnection: IDBConnection);
var
  bResultado: boolean;
begin
  oProdFDMemTable := pProdFDMemTable;
  oDBConnection := pDBConnection;

  oProdFDMemTable.DisableControls;

  ComandosSL := TStringList.Create;
  oDBConnection.Abrir;
  try
    oProdFDMemTable.First;
    SetLength(aPreco, 1);
    while not oProdFDMemTable.Eof do
    begin
      LerCampos;

      oProdFDMemTable.Next;
    end;
  finally
    pProdFDMemTable.First;
    pProdFDMemTable.EnableControls;
    ComandosSL.Free;
    oDBConnection.Fechar;
  end;
end;

end.
