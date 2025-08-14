unit Loja_dbi_u;

interface

uses Sis_u, Log_u, DBServDM_u;

function CarregueLoja: Boolean;

implementation

uses Data.DB, System.SysUtils, Sis.Win.Utils_u, Sis.Log;

function CarregueLoja: Boolean;
var
  sSql: string;
  Q: TDataSet;
begin
  Log.Escreva('CarregueLoja');
  //EscrevaLog('CarregueLoja');

  try
    DBServDM.Connection.Open;
    Result := True;
  except
    on e: exception do
    begin
      Result := False;
      Log.Escreva('Erro CarregueLoja: ' + e.message);
      //EscrevaLog('Erro CarregueLoja: ' + e.message);
    end;
  end;

  try
    sSql := 'SELECT'#13#10 //
      + 'LOJA_ID'#13#10 // 0
      + 'FROM LOJA_INICIAL_PA.SELECIONADO_GET'#13#10 //
      + ';';

//     {$IFDEF DEBUG}
//     CopyTextToClipboard(sSql);
//     {$ENDIF}
    DBServDM.Connection.ExecSQL(sSql, Q);

    Result := Assigned(Q);
    if not Result then
      exit;

    try
      iLojaId := Q.Fields[0 { LOJA_ID } ].AsInteger;
    finally
      Q.Free;
    end;
  finally
    DBServDM.Connection.Close;
  end;
end;

end.
