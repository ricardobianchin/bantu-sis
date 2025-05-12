unit App.Est.EstMovDBI_u;

interface

uses App.Ent.DBI_u, App.Est.EstMovDBI, Sis.Entities.Types, Sis.Types;

type
  TEstMovDBI = class(TEntDBI, IEstMovDBI)
  public
    procedure EstMovCancele(pLojaId: TLojaId; pTerminalId: TTerminalId;
      pEstMovId: Int64);
    procedure EstMovCanceleItem(pLojaId: TLojaId; pTerminalId: TTerminalId;
      pEstMovId: Int64; pOrdem: SmallInt);
  end;

implementation

uses System.SysUtils;

{ TEstMovDBI }

procedure TEstMovDBI.EstMovCancele(pLojaId: TLojaId; pTerminalId: TTerminalId;
  pEstMovId: Int64);
var
  sSql: String;
  sMens: string;
  Result: Boolean;
begin
  sSql := //
    'UPDATE EST_MOV SET'#13#10 //
    + 'CANCELADO=TRUE'#13#10 //
    + 'WHERE'#13#10 //
    + 'LOJA_ID=' + pLojaId.ToString + #13#10 //
    + 'AND TERMINAL_ID=' + pTerminalId.ToString + #13#10 //
    + 'AND EST_MOV_ID=' + pEstMovId.ToString + #13#10 //
    ;
  // 'UPDATE EST_MOV SET EST_MOV_TIPO_ID='', DTH_DOC='', FINALIZADO=FALSE, CANCELADO=FALSE, CRIADO_EM='', ALTERADO_EM='1.1.1900', FINALIZADO_EM='1.1.1900', CANCELADO_EM='1.1.1900' WHERE LOJA_ID=0 AND TERMINAL_ID=0 AND EST_MOV_ID=0;

  Result := False;

  Result := DBConnection.Abrir;
  if not Result then
  begin
    sMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.ExecuteSQL(sSql);
  finally
    DBConnection.Fechar;
    Result := True;
  end;
end;

procedure TEstMovDBI.EstMovCanceleItem(pLojaId: TLojaId;
  pTerminalId: TTerminalId; pEstMovId: Int64; pOrdem: SmallInt);
var
  sSql: String;
  sMens: string;
  Result: Boolean;
begin
  sSql := //
    'UPDATE EST_MOV_ITEM SET'#13#10 //
    + 'CANCELADO=TRUE'#13#10 //
    + 'WHERE'#13#10 //
    + 'LOJA_ID=' + pLojaId.ToString + #13#10 //
    + 'AND TERMINAL_ID=' + pTerminalId.ToString + #13#10 //
    + 'AND EST_MOV_ID=' + pEstMovId.ToString + #13#10 //
    + 'AND ORDEM=' + pOrdem.ToString + #13#10 //
    ;
  // 'UPDATE EST_MOV SET EST_MOV_TIPO_ID='', DTH_DOC='', FINALIZADO=FALSE, CANCELADO=FALSE, CRIADO_EM='', ALTERADO_EM='1.1.1900', FINALIZADO_EM='1.1.1900', CANCELADO_EM='1.1.1900' WHERE LOJA_ID=0 AND TERMINAL_ID=0 AND EST_MOV_ID=0;

  Result := False;

  Result := DBConnection.Abrir;
  if not Result then
  begin
    sMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.ExecuteSQL(sSql);
  finally
    DBConnection.Fechar;
    Result := True;
  end;
end;

end.
