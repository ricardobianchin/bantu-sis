unit Sis.Web.HTTP.FileTranser_u;

interface

uses Sis.Sis.Executavel_u, Sis.Web.HTTP.FileTranser, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog;

type
  THTTPFileTranser = class(TExecutavel, IHTTPFileTranser)
  private
    FExluiDestinoAntes: Boolean;
    // FDtHLocal, FDtHRemoto : TDateTIme;
    FArqLocal, FArqRemoto: string;

    // IdHTTP1: TIdHTTP;
    // IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    // MS: TMemoryStream;
    // function ExecuteIndy: Boolean;
  public
    property ExluiDestinoAntes: Boolean read FExluiDestinoAntes
      write FExluiDestinoAntes;
    property ArqLocal: string read FArqLocal write FArqLocal;
    property ArqRemoto: string read FArqRemoto write FArqRemoto;

    constructor Create(pArqLocal, pArqRemoto: string;
      pExluiDestinoAntes: Boolean; pOutput: IOutput = nil;
      pProcessLog: IProcessLog = nil);
  end;

implementation

{ THTTPFileTranser }

uses Sis.Types.Bool_u;

constructor THTTPFileTranser.Create(pArqLocal, pArqRemoto: string;
  pExluiDestinoAntes: Boolean; pOutput: IOutput; pProcessLog: IProcessLog);
begin
  inherited Create(pOutput, pProcessLog);
  FExluiDestinoAntes := pExluiDestinoAntes;
  FArqLocal := pArqLocal;
  FArqRemoto := pArqRemoto;

  ProcessLog.PegueLocal(ClassName + '.Create');
  ProcessLog.RegistreLog('Local=' + FArqLocal + ',Remoto=' + FArqRemoto +
    ',ExluiDestinoAntes=' + BooleanToStr(FExluiDestinoAntes));
  ProcessLog.RetorneLocal;
end;

end.
