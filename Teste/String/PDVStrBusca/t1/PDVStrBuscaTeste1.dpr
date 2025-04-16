program PDVStrBuscaTeste1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  App.PDV.Venda.Utils_u in '..\..\..\..\App\Modulos\PDV\Venda\App.PDV.Venda.Utils_u.pas';


function PDVBuscaResultadoToStr(pPDVBuscaResultado: TPDVBuscaResultado): string;
begin
  Result := '';
  case pPDVBuscaResultado of
    pdvbrNaoDefinido: Result := 'pdvbrNaoDefinido';
    pdvbrStringNula: Result := 'pdvbrStringNula';
    pdvbrErro: Result := 'pdvbrErro';
    pdvbrValida: Result := 'pdvbrValida';
    pdvbrBuscarDescricao: Result := 'pdvbrBuscarDescricao';
  else
    Result := 'pdvbrNaoDefinido';
  end;
end;


procedure TestaBuscaNumericaStatus(const pStrBusca: string; pResultadoDesejado: TPDVBuscaResultado);
var
  i: Integer;
  lPDVBuscaResultado: TPDVBuscaResultado;
  sLinha: string;
begin
  sLinha := pStrBusca;

  lPDVBuscaResultado := BuscaNumericaStatus(pStrBusca);

  if lPDVBuscaResultado = pResultadoDesejado then
    //sLinha := sLinha + ' - OK retornou '  + PDVBuscaResultadoToStr(lPDVBuscaResultado)
  else
  begin
    sLinha := sLinha + ' - ERRO: ' + PDVBuscaResultadoToStr(lPDVBuscaResultado) +
      ' <> ' + PDVBuscaResultadoToStr(pResultadoDesejado);
  Writeln(sLinha);
  end;
end;





begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Writeln('Teste de BuscaNumericaStatus:');
    Writeln('----------------------------------');
//    TestaBuscaNumericaStatus('123', pdvbrValida);
//    TestaBuscaNumericaStatus('A', pdvbrBuscarDescricao);
//    TestaBuscaNumericaStatus('', pdvbrStringNula);
//    TestaBuscaNumericaStatus('.', pdvbrErro);
//    TestaBuscaNumericaStatus(',', pdvbrErro);
//    TestaBuscaNumericaStatus(',3', pdvbrErro);
//    TestaBuscaNumericaStatus('3.', pdvbrErro);
//    TestaBuscaNumericaStatus('*', pdvbrErro);
//    TestaBuscaNumericaStatus('*4', pdvbrErro);
//    TestaBuscaNumericaStatus('4*', pdvbrErro);
//    TestaBuscaNumericaStatus('3*4', pdvbrValida);
//    TestaBuscaNumericaStatus('3*4,5', pdvbrValida);
//    TestaBuscaNumericaStatus('3*4.15', pdvbrValida);
//    TestaBuscaNumericaStatus('3,4*5', pdvbrErro);
//    TestaBuscaNumericaStatus('3.4*6', pdvbrErro);
    TestaBuscaNumericaStatus('3,4*6A', pdvbrBuscarDescricao);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
