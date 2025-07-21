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
  // todos os valores data aqui sao truncados. so tem a parte date. a parte time é sempre zerada
  // aqui quero um loop que chame o metodo ReconstruaFaixa com intervalos de datas de 3 meses cada
  // inicia colocando o valor de pDtIni em DtFaixaIni
  // a cada volta, pDtFin recebe min(pDtFin, DtFaixaIni + 3 meses)
  // para incrementar 3 meses, deve usar IncMonth(3) do delphi
  // a cada volta do loop chama ReconstruaFaixa(DtFaixaIni, DtFaixaFin);

  DtFaixaIni := pDtIni; // Inicia com a data inicial

  while DtFaixaIni < pDtFin do
  begin
    MesesAFrente := DtFaixaIni.IncMonth(MESES_INTERVALO);

    // Calcula o fim da faixa (mínimo entre pDtFin e DtFaixaIni + 3 meses)
    DtFaixaFin := Min(pDtFin, MesesAFrente);

    // Chama o processamento para a faixa atual
    EstSaldoReconstruaFaixa(pProdSaldoArray, DtFaixaIni, DtFaixaFin);

    // Avança para o próximo intervalo de 3 meses
    DtFaixaIni := DtFaixaFin;
  end;
end;

end.
