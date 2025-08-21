unit Sis.Web.FTP.Frame_u;

interface

uses
  System.SysUtils, System.Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP,
  Vcl.Dialogs, IdFTPCommon;

type
  TFtpDM = class(TDataModule)
    IdFTP1: TIdFTP;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Put(pLocalArq, pRemoteArq: string; out pErroDeu: Boolean;
      out pErroMens: string);
    procedure Get(pRemoteArq, pLocalArq: string; out pErroDeu: Boolean;
      out pErroMens: string);
  end;

procedure Put(pLocalArq, pRemoteArq: string; out pErroDeu: Boolean;
  out pErroMens: string);

// var
// FtpDM: TFtpDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses System.StrUtils;

procedure Put(pLocalArq, pRemoteArq: string; out pErroDeu: Boolean;
  out pErroMens: string);
var
  oFtpDM: TFtpDM;
begin
  oFtpDM := TFtpDM.Create(nil);
  try
    oFtpDM.Put(pLocalArq, pRemoteArq, pErroDeu, pErroMens);
  finally
    oFtpDM.Free;
  end;
end;

{ TFtpDM }

procedure TFtpDM.Get(pRemoteArq, pLocalArq: string; out pErroDeu: Boolean;
  out pErroMens: string);
begin
  pErroDeu := False;
  pErroMens := '';

  try
    // Configuração do componente FTP
    IdFTP1.Host := 'ftp.bianch.in';
    IdFTP1.Username := 'bianchin';
    IdFTP1.Password := '+89Bib.OA6rX5m';
    IdFTP1.Port := 21;
    IdFTP1.TransferType := ftBinary;
    IdFTP1.Passive := False; // hospedagem geralmente exige modo passivo

    // Conecta
    IdFTP1.Connect;
    try
      // Faz download do arquivo remoto para o caminho local
      IdFTP1.Get(pRemoteArq, pLocalArq, True, False);
      // 1º True = sobrescreve o arquivo local, se já existir
      // 2º False = não usa modo de "resume" (recomeçar de onde parou)
    finally
      IdFTP1.Disconnect;
    end;

  except
    on E: Exception do
    begin
      pErroDeu := True;
      pErroMens := 'Erro no download: ' + E.Message;
    end;
  end;
end;

procedure TFtpDM.Put(pLocalArq, pRemoteArq: string; out pErroDeu: Boolean;
  out pErroMens: string);
var
  DiretorioAtual: string;
  Lista: TStringList;
  PosSep: Integer;
  sPasta: string;
  sArq: string;
  aPastas: TArray<string>;
  i: Integer;
begin
  pErroDeu := False;
  pErroMens := '';

  Lista := TStringList.Create;
  try
    // Configuração do componente FTP
    IdFTP1.Host := 'ftp.bianch.in';
    IdFTP1.Username := 'bianchin';
    IdFTP1.Password := '+89Bib.OA6rX5m';
    IdFTP1.Port := 21;
    IdFTP1.TransferType := ftBinary;
    // IdFTP1.Passive := True; // hospedagens quase sempre exigem modo passivo
    IdFTP1.Passive := False;

    // Conecta
    IdFTP1.Connect;
    try
      // Envia o arquivo

      aPastas := pRemoteArq.Split(['/']);

      IdFTP1.ChangeDir('/' + aPastas[1]);
      for i := 2 to High(aPastas) - 1 do
        IdFTP1.ChangeDir(aPastas[i]);

      PosSep := LastDelimiter('/', pRemoteArq);
      sArq := RightStr(pRemoteArq, Length(pRemoteArq) - PosSep);
      // IdFTP1.ChangeDir(sPasta);
      // DiretorioAtual := IdFTP1.RetrieveCurrentDir; // pega o diretório remoto atual
      IdFTP1.Put(pLocalArq, sArq, False);
      // False = não sobrescreve automaticamente
      // se quiser sempre sobrescrever, use True
    finally
      IdFTP1.Disconnect;
      Lista.Free;
    end;

  except
    on E: Exception do
    begin
      pErroDeu := True;
      pErroMens := 'Erro no upload: ' + E.Message;
    end;
  end;
end;

end.
