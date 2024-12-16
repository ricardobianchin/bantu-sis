unit App.Sis.Assist_u;

interface

uses App.AppObj;

procedure AssistAbrir(pAppObj: IAppObj);
procedure AssistPedirPraFechar;

implementation

uses Sis.Win.Utils_u;

procedure AssistAbrir(pAppObj: IAppObj);
var
  sPasta, sParams, sNomeArq, sErro: string;
begin
  sPasta := pAppObj.AppInfo.PastaBin;
  sParams := '';
  sNomeArq := sPasta + 'Assist.exe';

  ExecutePrograma(sNomeArq, sParams, sPasta, sErro);
end;

procedure AssistPedirPraFechar;
begin

end;

end.
