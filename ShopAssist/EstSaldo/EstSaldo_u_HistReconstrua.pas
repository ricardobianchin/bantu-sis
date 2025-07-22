unit EstSaldo_u_HistReconstrua;

interface

uses EstSaldo_u_ProdSaldoArrayType;

procedure EstSaldoHistReconstrua(pProdSaldoArray: TProdSaldoArray; pDtIni, pDtFin: TDateTime);

implementation

uses DateUtils, System.SysUtils, System.Math, Sis.Types.Dates, EstSaldo_u_dbi;

const
  MESES_INTERVALO = 3;

procedure EstSaldoHistReconstrua(pProdSaldoArray: TProdSaldoArray; pDtIni, pDtFin: TDateTime);
var
  DtFaixaIni, DtFaixaFin: TDateTime;
  MesesAFrente: TDateTime;
begin
  DtFaixaIni := pDtIni; // Inicia com a data inicial

  EstSaldoHistLeia(pProdSaldoArray, DtFaixaIni);

  while DtFaixaIni < pDtFin do
  begin
    MesesAFrente := DtFaixaIni.IncMonth(MESES_INTERVALO);

    // Calcula o fim da faixa (mínimo entre pDtFin e DtFaixaIni + 3 meses)
    DtFaixaFin := Min(pDtFin, MesesAFrente);

    // Chama o processamento para a faixa atual
    ComputeMovimento(pProdSaldoArray, DtFaixaIni, DtFaixaFin);

    EstSaldoHistGrave(pProdSaldoArray, DtFaixaFin);

    // Avança para o próximo intervalo de 3 meses
    DtFaixaIni := DtFaixaFin;
  end;
end;

end.
