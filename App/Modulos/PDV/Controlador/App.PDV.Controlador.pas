unit App.PDV.Controlador;

interface

uses
  System.SysUtils, Sis.Types;

type
  IPDVControlador = interface(IInterface)
    ['{0508C8A4-5992-4949-BD1A-0A71BFB746B1}']
//    procedure IniciarTelaVenda;
    function GetVaParaVenda: TProcedureOfObject;
    function GetVaParaPag: TProcedureOfObject;
    function GetVaParaFinaliza: TProcedureOfObject;
    function GetPagSomenteDinheiro: TProcedureOfObject;
    function GetDecidirPrimeiroFrameAtivo: TProcedureOfObject;

    property VaParaVenda: TProcedureOfObject read GetVaParaVenda;
    property VaParaPag: TProcedureOfObject read GetVaParaPag;
    property VaParaFinaliza: TProcedureOfObject read GetVaParaFinaliza;
    property PagSomenteDinheiro: TProcedureOfObject read GetPagSomenteDinheiro;
    property DecidirPrimeiroFrameAtivo: TProcedureOfObject read GetDecidirPrimeiroFrameAtivo;

    procedure PegarProcs( //
      pVaParaVenda: TProcedureOfObject; //
      pVaParaPag: TProcedureOfObject; //
      pVaParaFinaliza: TProcedureOfObject; //
      pPagSomenteDinheiro: TProcedureOfObject; //
      pDecidirPrimeiroFrameAtivo: TProcedureOfObject //
      );

  end;

implementation

end.
