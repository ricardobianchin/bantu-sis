unit App.PDV.Controlador_u;

interface

uses App.PDV.Controlador, System.SysUtils, Sis.Types;

type
  TPDVControlador = class(TInterfacedObject, IPDVControlador)
  private
    FVaParaVenda: TProcedureOfObject;
    FVaParaPag: TProcedureOfObject;
    FVaParaFinaliza: TProcedureOfObject;
    FPagSomenteDinheiro: TProcedureOfObject;
    FDecidirPrimeiroFrameAtivo: TProcedureOfObject;
    function GetVaParaVenda: TProcedureOfObject;
    function GetVaParaPag: TProcedureOfObject;
    function GetVaParaFinaliza: TProcedureOfObject;
    function GetPagSomenteDinheiro: TProcedureOfObject;
    function GetDecidirPrimeiroFrameAtivo: TProcedureOfObject;
  public
    procedure PegarProcs( //
      pVaParaVenda: TProcedureOfObject; //
      pVaParaPag: TProcedureOfObject; //
      pVaParaFinaliza: TProcedureOfObject; //
      pPagSomenteDinheiro: TProcedureOfObject; //
      pDecidirPrimeiroFrameAtivo: TProcedureOfObject //
      );

    property VaParaVenda: TProcedureOfObject read GetVaParaVenda;
    property VaParaPag: TProcedureOfObject read GetVaParaPag;
    property VaParaFinaliza: TProcedureOfObject read GetVaParaFinaliza;
    property PagSomenteDinheiro: TProcedureOfObject read GetPagSomenteDinheiro;
    property DecidirPrimeiroFrameAtivo: TProcedureOfObject read GetDecidirPrimeiroFrameAtivo;
  end;

implementation

procedure TPDVControlador.PegarProcs( //
  pVaParaVenda: TProcedureOfObject; //
  pVaParaPag: TProcedureOfObject; //
  pVaParaFinaliza: TProcedureOfObject; //
  pPagSomenteDinheiro: TProcedureOfObject; //
  pDecidirPrimeiroFrameAtivo: TProcedureOfObject //
  );
begin
  FVaParaVenda := pVaParaVenda;
  FVaParaPag := pVaParaPag;
  FVaParaFinaliza := pVaParaFinaliza;
  FPagSomenteDinheiro := pPagSomenteDinheiro;
  FDecidirPrimeiroFrameAtivo := pDecidirPrimeiroFrameAtivo;
end;

function TPDVControlador.GetVaParaVenda: TProcedureOfObject;
begin
  Result := FVaParaVenda;
end;

function TPDVControlador.GetVaParaPag: TProcedureOfObject;
begin
  Result := FVaParaPag;
end;

function TPDVControlador.GetVaParaFinaliza: TProcedureOfObject;
begin
  Result := FVaParaFinaliza;
end;

function TPDVControlador.GetPagSomenteDinheiro: TProcedureOfObject;
begin
  Result := FPagSomenteDinheiro;
end;

function TPDVControlador.GetDecidirPrimeiroFrameAtivo: TProcedureOfObject;
begin
  Result := FDecidirPrimeiroFrameAtivo;
end;

end.
