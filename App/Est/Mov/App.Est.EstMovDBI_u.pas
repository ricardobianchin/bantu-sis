unit App.Est.EstMovDBI_u;

interface

uses App.Ent.DBI_u, App.Est.EstMovDBI, Sis.Entities.Types, Sis.Types,
  Sis.DB.DBTypes, App.Ent.Ed, App.AppObj, App.Est.EstMovItem;

type
  TEstMovDBI = class(TEntDBI, IEstMovDBI)
  private
    FAppObj: IAppObj;
    FUsuarioId: TId;
    FMachId: string;
  protected
    property UsuarioId: TId read FUsuarioId;
    property AppObj: IAppObj read FAppObj;
    property sMachId: string read FMachId;
  public
    procedure EstMovCancele(out pCanceladoEm: TDateTime; out pErroDeu: Boolean;
      out pErroMens: string; pLojaId: TLojaId; pEstMovId: Int64;
      pTerminalId: TTerminalId = 0; pModuloSisId: Char = '"');

    procedure EstMovCanceleItem(out pErroDeu: Boolean; out pErroMens: string;
      pLojaId: TLojaId; pEstMovId: Int64; pOrdem: SmallInt;
      pTerminalId: TTerminalId = 0; pModuloSisId: Char = '"');

    procedure EstMovFinalize(out pFinalizadoEm: TDateTime;
      out pErroDeu: Boolean; out pErroMens: string; pLojaId: TLojaId;
      pEstMovId: Int64; pTerminalId: TTerminalId = 0; pModuloSisId: Char = '#');

    constructor Create(pDBConnection: IDBConnection; pEntEd: IEntEd;
      pAppObj: IAppObj; pUsuarioId: TId);
  end;

implementation

uses System.SysUtils, Data.DB;

{ TEstMovDBI }

constructor TEstMovDBI.Create(pDBConnection: IDBConnection; pEntEd: IEntEd;
  pAppObj: IAppObj; pUsuarioId: TId);
begin
  inherited Create(pDBConnection, pEntEd);
  FUsuarioId := pUsuarioId;
  FAppObj := pAppObj;
  FMachId := AppObj.SisConfig.LocalMachineId.IdentId.ToString;
end;

procedure TEstMovDBI.EstMovCancele(out pCanceladoEm: TDateTime;
  out pErroDeu: Boolean; out pErroMens: string; pLojaId: TLojaId;
  pEstMovId: Int64; pTerminalId: TTerminalId; pModuloSisId: Char);
var
  sSql: string;
  q: TDataSet;
begin
  sSql := //
    'SELECT'#13#10 //

    + 'CANCELADO_EM_RET'#13#10 //

    + 'FROM EST_MOV_MANUT_PA.EST_MOV_CANCELE'#13#10 //

    + '('#13#10 //
    + '  ' + pLojaId.ToString + ' -- LOJA_ID'#13#10 //
    + '  , ' + pTerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + pEstMovId.ToString + ' -- EST_MOV_ID'#13#10 //

    + '  , ' + FUsuarioId.ToString + ' -- LOG_PESSOA_ID'#13#10 //
    + '  , ' + sMachId + ' -- MACHINE_ID'#13#10 //
    + '  , ' + QuotedStr(pModuloSisId) + ' -- MODULO_SIS_ID'#13#10 //

    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  pErroDeu := not DBConnection.Abrir;
  if pErroDeu then
  begin
    pErroMens := 'Erro ao tentar cancelar Nota. ' + DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.QueryDataSet(sSql, q);
    pCanceladoEm := q.Fields[0].AsDateTime;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TEstMovDBI.EstMovCanceleItem(out pErroDeu: Boolean;
  out pErroMens: string; pLojaId: TLojaId; pEstMovId: Int64; pOrdem: SmallInt;
  pTerminalId: TTerminalId; pModuloSisId: Char);
var
  sSql: string;
  dCanceladoEm: TDateTime;
  q: TDataSet;
begin
  try
    sSql := //
      'SELECT'#13#10 //

      + 'CANCELADO_EM_RET'#13#10 //

      + 'FROM EST_MOV_MANUT_PA.EST_MOV_ITEM_CANCELE'#13#10 //
      + '('#13#10 //
      + '  ' + pLojaId.ToString + ' -- LOJA_ID'#13#10 //
      + '  , ' + pTerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
      + '  , ' + pEstMovId.ToString + ' -- EST_MOV_ID'#13#10 //
      + '  , ' + pOrdem.ToString + ' -- ORDEM'#13#10 //

      + '  , ' + FUsuarioId.ToString + ' -- LOG_PESSOA_ID'#13#10 //
      + '  , ' + sMachId + ' -- MACHINE_ID'#13#10 //
      + '  , ' + QuotedStr(pModuloSisId) + ' -- MODULO_SIS_ID'#13#10 //
      + ');';

    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}

    pErroDeu := not DBConnection.Abrir;
    if pErroDeu then
    begin
      pErroMens := 'Erro ao tentar cancelar item. ' + DBConnection.UltimoErro;
      exit;
    end;

    try
      DBConnection.QueryDataSet(sSql, q);
      dCanceladoEm := q.Fields[0].AsDateTime;
    finally
      DBConnection.Fechar;
    end;
  except
    on e: Exception do
    begin
      pErroDeu := True;
      pErroMens := 'Erro ao tentar cancelar item. ' + e.ClassName + ', ' +
        e.Message;
    end;
  end;
end;

procedure TEstMovDBI.EstMovFinalize(out pFinalizadoEm: TDateTime;
  out pErroDeu: Boolean; out pErroMens: string; pLojaId: TLojaId;
  pEstMovId: Int64; pTerminalId: TTerminalId; pModuloSisId: Char);
var
  sSql: string;
  q: TDataSet;
begin
  sSql := //
    'SELECT'#13#10 //

    + 'FINALIZADO_EM_RET'#13#10 //

    + 'FROM EST_MOV_MANUT_PA.EST_MOV_FINALIZE'#13#10 //

    + '('#13#10 //
    + '  ' + pLojaId.ToString + ' -- LOJA_ID'#13#10 //
    + '  , ' + pTerminalId.ToString + ' -- TERMINAL_ID'#13#10 //
    + '  , ' + pEstMovId.ToString + ' -- EST_MOV_ID'#13#10 //

    + '  , ' + FUsuarioId.ToString + ' -- LOG_PESSOA_ID'#13#10 //
    + '  , ' + sMachId + ' -- MACHINE_ID'#13#10 //
    + '  , ' + QuotedStr(pModuloSisId) + ' -- MODULO_SIS_ID'#13#10 //

    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  pErroDeu := not DBConnection.Abrir;
  if pErroDeu then
  begin
    pErroMens := 'Erro ao tentar Finalizar Nota. ' + DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.QueryDataSet(sSql, q);
    pFinalizadoEm := q.Fields[0].AsDateTime;
  finally
    DBConnection.Fechar;
  end;
end;

end.
