unit App.Pess.Loja.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u, App.Pess.Loja.DBI,
  App.Pess.Loja.Ent, App.Pess.Geral.Factory_u, App.Pess.DBI_u;

type
  TPessLojaDBI = class(TPessDBI, IPessLojaDBI)
  private
    FPessLojaEnt: IPessLojaEnt;
  protected
    procedure DataSetToEnt(Q: TDataSet); override;
    function GetSqlPreencherDataSet(pValues: variant): string; override;
  public
    constructor Create(pDBConnection: IDBConnection; pPessLojaEnt: IPessLojaEnt);
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TPessLojaDBI }

constructor TPessLojaDBI.Create(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt);
begin
  inherited Create(pDBConnection, pPessLojaEnt);
  FPessLojaEnt := pFPessLojaEnt;
end;

procedure TPessLojaDBI.DataSetToEnt(Q: TDataSet);
begin

  FPessLojaEnt. := q.Fields[29 {ATIVO}].As;



  Ent.Descr := q.Fields[1].AsString.Trim;
  Ent.DescrRed := q.Fields[2].AsString.Trim;

  Ent.ProdFabrEnt.Id := q.Fields[3].AsInteger;
  Ent.ProdTipoEnt.Id := q.Fields[4].AsInteger;





end;

function TPessLojaDBI.GetSqlPreencherDataSet(pValues: variant): string;
var
  iLojaId: integer;
begin
  iLojaId := FPessLojaEntk.LojaId;

  Result := 'Select'#13#10//
    + ' LOJA_ID'#13#10 // 0
    + ', PESSOA_ID'#13#10 // 1
    + ', APELIDO'#13#10 // 2
    + ', NOME'#13#10 // 3
    + ', NOME_FANTASIA'#13#10 // 4
    + ', C'#13#10 // 5
    + ', I'#13#10 // 6
    + ', M'#13#10 // 7
    + ', M_UF'#13#10 // 8
    + ', EMAIL'#13#10 // 9
    + ', DT_NASC'#13#10 // 10
    + ', PESS_EDITADO_EM'#13#10 // 11
    + ', PESS_CRIADO_EM'#13#10 // 12
    + ', ENDER_ORDEM'#13#10 // 13
    + ', LOGRADOURO'#13#10 // 14
    + ', NUMERO'#13#10 // 15
    + ', COMPLEMENTO'#13#10 // 16
    + ', BAIRRO'#13#10 // 17
    + ', UF_SIGLA'#13#10 // 18
    + ', CEP'#13#10 // 19
    + ', MUNICIPIO_IBGE_ID'#13#10 // 20
    + ', DDD'#13#10 // 21
    + ', FONE1'#13#10 // 22
    + ', FONE2'#13#10 // 23
    + ', FONE3'#13#10 // 24
    + ', CONTATO'#13#10 // 25
    + ', REFERENCIA'#13#10 // 26
    + ', ENDER_CRIADO_EM'#13#10 // 27
    + ', ENDER_ALTERADO_EM'#13#10 // 28
    + ', ATIVO'#13#10 // 29
    + 'FROM LOJA_MANUT_PA.LISTA_GET(' //
    + iLojaId.ToString //
    + ');'#13#10 //
    ;
end;

function TPessLojaDBI.Inserir(out pNovaId: variant): boolean;
begin

end;

end.
