unit App.PDV.AppPDVObj_u;

interface

uses App.PDV.CaixaSessao, App.PDV.AppPDVObj;

type
  TAppPDVObj = class(TInterfacedObject, IAppPDVObj)
  private
    FCaixaSessao: ICaixaSessao;

    function GetCaixaSessao: ICaixaSessao;
  public
    property CaixaSessao: ICaixaSessao read GetCaixaSessao;
    constructor Create(PCaixaSessao: ICaixaSessao);
  end;

implementation

{ TAppPDVObj }

constructor TAppPDVObj.Create(pCaixaSessao: ICaixaSessao);
begin
  FCaixaSessao := pCaixaSessao;
end;

function TAppPDVObj.GetCaixaSessao: ICaixaSessao;
begin
  Result := FCaixaSessao
end;

end.

end.
