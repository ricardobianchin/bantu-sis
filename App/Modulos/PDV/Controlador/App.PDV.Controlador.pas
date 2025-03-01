unit App.PDV.Controlador;

interface

type
  IPDVControlador = interface(IInterface)
    ['{0508C8A4-5992-4949-BD1A-0A71BFB746B1}']
//    procedure IniciarTelaVenda;
    procedure VaParaVenda;
    procedure VaParaPag;
    procedure VaParaFinaliza;
    procedure PagSomenteDinheiro;
    procedure DecidirPrimeiroFrameAtivo;
  end;

implementation

end.
