unit App.PDV.Controlador;

interface

type
  IPDVControlador = interface(IInterface)
    ['{0508C8A4-5992-4949-BD1A-0A71BFB746B1}']
    procedure Iniciar;
    procedure IrParaVenda;
    procedure IrParaPag;
    procedure IrParaFinaliza;
  end;

implementation

end.