unit App.Retag.Est.Saldo.DBI_u;

interface

uses App.Ent.DBI_u, App.Retag.Est.Saldo.DBI, App.Retag.Est.Saldo.Ent, Sis.DB.DBTypes;

type
  TRetagSaldoDBI = class(TEntDBI, IRetagSaldoDBI)
  private
    FRetagSaldoEnt: IRetagSaldoEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;
  public
    constructor Create(pDBConnection: IDBConnection;
      pRetagSaldoEnt: IRetagSaldoEnt); reintroduce;
  end;

implementation

uses App.Retag.Est.Factory, System.SysUtils, Sis.Entities.Types;

{ TRetagSaldoDBI }

constructor TRetagSaldoDBI.Create(pDBConnection: IDBConnection;
  pRetagSaldoEnt: IRetagSaldoEnt);
begin
  inherited Create(pDBConnection, pRetagSaldoEnt);
  FRetagSaldoEnt := pRetagSaldoEnt;
end;

function TRetagSaldoDBI.GetSqlForEach(pValues: variant): string;
begin

  Result := 'SELECT'#13#10 //

    +'PROD_ID'#13#10 //

    + ', DESCR'#13#10 //
    + ', DESCR_RED'#13#10 //

    + ', FABR_ID'#13#10 //
    + ', FABR_NOME'#13#10 //

    + ', PROD_TIPO_ID'#13#10 //
    + ', PROD_TIPO_DESCR'#13#10 //

    + ', UNID_ID'#13#10 //
    + ', UNID_SIGLA'#13#10 //

    + ', COD_BARRAS'#13#10 //

    + ', SALDO'#13#10 //

    + ', CUSTO_UNIT'#13#10 //
    + ', CUSTO_TOTAL'#13#10 //

    + ', PRECO_UNIT'#13#10 //
    + ', PRECO_TOTAL'#13#10 //

    + ', ATIVO'#13#10 //
    + ', LOCALIZ'#13#10 //
    + ', CAPAC_EMB'#13#10 //

    + ', BALANCA_EXIGE'#13#10 //


    + 'FROM EST_SALDO_RETAG_PA.SALDO_TELA_LISTA_GET(' //
    + FRetagSaldoEnt.LojaId.ToString + ', '''', FALSE, TRUE, FALSE, FALSE, FALSE'
    + ');'#13#10 //
    ;

//{$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//{$ENDIF}

end;

end.
