unit App.Pdv.CupomEspelho_u;

interface

uses Sis.Files.Recorder_u, App.Pdv.CupomEspelho, App.AppObj;

type
  TCupomEspelho = class(TFIleRecorder, ICupomEspelho)
  private
//    FAppObj: IAppObj;
  public
    constructor Create(pAppObj: IAppObj; pTipoCupom: string);
  end;

implementation

{ TCupomEspelho }

constructor TCupomEspelho.Create(pAppObj: IAppObj; pTipoCupom: string);
var
  sPastaRaiz: string;
  sAssunto: string;
begin
  sPastaRaiz := pAppObj.AppInfo.PastaDocs+'Cupom\Espelho\';
  sAssunto :=  'Cupom Espelho '+pTipoCupom;
  inherited Create(sPastaRaiz, sAssunto);
//  FAppObj := pAppObj;
end;

end.
