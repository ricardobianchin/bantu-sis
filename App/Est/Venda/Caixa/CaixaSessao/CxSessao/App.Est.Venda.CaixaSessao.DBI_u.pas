unit App.Est.Venda.CaixaSessao.DBI_u;

interface

uses Sis.DBI_u, App.Est.Venda.CaixaSessao.DBI, Sis.DB.DBTypes, Sis.Usuario,
  Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.Terminal, Sis.Entidade, App.Est.Venda.Caixa.CaixaSessao,
  Sis.Entities.Types, Data.DB, FireDAC.Comp.Client, System.Classes,
  App.Est.Venda.CaixaSessaoRecord_u;

type
  /// <summary>
  /// TCaixaSessaoDBI é uma classe que implementa as funcionalidades de sessão de caixa.
  /// </summary>
  TCaixaSessaoDBI = class(TDBI, ICaixaSessaoDBI)
  private
    FLojaId: TLojaId;
    FTerminalId: TTerminalId;
    FMachineIdentId: smallint;
    FLogUsuario: IUsuario;
    FMensagem: string;
    function GetMensagem: string;
  public
    constructor Create(pDBConnection: IDBConnection; pLogUsuario: IUsuario;
      pLojaId: TLojaId; pTerminalId: TTerminalId; pMachineIdentId: smallint);
      reintroduce;

    function CaixaSessaoAbertoGet(pCaixaSessaoRec: TCaixaSessaoRec)
      : Boolean;

    function CaixaSessaoUltimoGet(pCaixaSessao: ICaixaSessao)
      : Boolean;

    property Mensagem: string read GetMensagem;
    procedure PDVCarregarDataSet(pDMemTable1: TFDMemTable;
      pCaixaSessao: ICaixaSessao);

    procedure PreenchaCxSessRelatorio(pLinhas: TStrings;
      pCaixaSessao: ICaixaSessao);
  end;

implementation

uses Sis.Win.Utils_u, Sis.DB.Factory, Sis.Types.Dates, System.SysUtils;

{ TCaixaSessaoDBI }

function TCaixaSessaoDBI.CaixaSessaoAbertoGet(pCaixaSessaoRec: TCaixaSessaoRec): Boolean;
var
  sSql: string;
  q: TDataSet;
begin
  pCaixaSessaoRec.Zerar;

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    sSql := 'SELECT'#13#10 //
      + 'SESS_ID'#13#10 // 0
      + ', PESSOA_ID'#13#10 // 1
      + ', APELIDO'#13#10 // 2
      + ', ABERTO_EM'#13#10 // 3
      + 'FROM CAIXA_SESSAO_MANUT_PA.ABERTO_GET'#13#10;
    // {$IFDEF DEBUG}
    // CopyTextToClipboard(sSql);
    // {$ENDIF}
    DBConnection.QueryDataSet(sSql, q);

    Result := Assigned(q);
    if not Result then
      exit;
    try
      Result := not q.IsEmpty;

      if not Result then
        exit;

      pCaixaSessaoRec.SessId := q.Fields[0].AsInteger;
      pCaixaSessaoRec.PessoaId := q.Fields[1].AsInteger;
      pCaixaSessaoRec.Apelido := q.Fields[2].AsString;
      pCaixaSessaoRec.AbertoEm := q.Fields[3].AsDateTime;
      pCaixaSessaoRec.Aberto := True;
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

function TCaixaSessaoDBI.CaixaSessaoUltimoGet(pCaixaSessao
  : ICaixaSessao): Boolean;
var
  oDBQuery: IDBQuery;
  sSql: string;
begin
//{$IFNDEF DEBUG}
  sSql := 'select FIRST(1)' + //
    ' LOJA_ID' + //
    ', TERMINAL_ID' + //
    ', SESS_ID' + //

    ' FROM CAIXA_SESSAO' + //
    ' ORDER BY SESS_ID DESC' //

    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  oDBQuery := DBQueryCreate('CxOperaca.formapag.lista.get.q', DBConnection,
    sSql, nil, nil);

  try
    oDBQuery.Abrir;
    try
      pCaixaSessao.LojaId := oDBQuery.DataSet.Fields[0].AsInteger;
      pCaixaSessao.TerminalId := oDBQuery.DataSet.Fields[1].AsInteger;
      pCaixaSessao.Id := oDBQuery.DataSet.Fields[2].AsInteger;
    finally
      oDBQuery.Fechar;
    end;
  finally
    DBConnection.Fechar;
  end;

//{$ELSE}
  pCaixaSessao.LojaId := 1;
  pCaixaSessao.TerminalId := 1;
  pCaixaSessao.Id := 1;
//{$ENDIF}
end;

constructor TCaixaSessaoDBI.Create(pDBConnection: IDBConnection;
  pLogUsuario: IUsuario; pLojaId: TLojaId; pTerminalId: TTerminalId;
  pMachineIdentId: smallint);
begin
  inherited Create(pDBConnection);
  FLogUsuario := pLogUsuario;
  FLojaId := pLojaId;
  FTerminalId := pTerminalId;
  FMachineIdentId := pMachineIdentId;
end;

function TCaixaSessaoDBI.GetMensagem: string;
begin
  Result := FMensagem;
end;

procedure TCaixaSessaoDBI.PDVCarregarDataSet(pDMemTable1: TFDMemTable;
  pCaixaSessao: ICaixaSessao);
var
  oDBQuery: IDBQuery;
  sSql: string;
  t: TFDMemTable;
  q: TDataSet;
begin
  t := pDMemTable1;

  DBConnection.Abrir;
  try
    oDBQuery := DBQueryCreate('CxOperaca.formapag.lista.get.q', DBConnection,
      sSql, nil, nil);

    pDMemTable1.DisableControls;
    pDMemTable1.Indexes.Clear;
    pDMemTable1.EmptyDataSet;
    pDMemTable1.BeginBatch;

    try
      if pCaixaSessao.Id < 1 then
        exit;
      sSql := //
        'WITH T AS'#13#10 + //
        '('#13#10 + //
        '  SELECT OPER_TIPO_ID, NAME'#13#10 + //
        '  FROM CAIXA_SESSAO_OPERACAO_TIPO'#13#10 + //
        '), O AS'#13#10 + //
        '('#13#10 + //
        '  SELECT LOJA_ID, TERMINAL_ID, SESS_ID, OPER_ORDEM,'#13#10 + //
        '  OPER_LOG_ID, OPER_TIPO_ID, VALOR, OBS, CANCELADO'#13#10 + //
        '  FROM CAIXA_SESSAO_OPERACAO'#13#10 + //
        '  WHERE LOJA_ID = ' + pCaixaSessao.LojaId.ToString + #13#10 + //
        '  AND TERMINAL_ID = ' + pCaixaSessao.TerminalId.ToString + #13#10 +
      //
        '  AND SESS_ID = ' + pCaixaSessao.Id.ToString + #13#10 + //
        '), L AS'#13#10 + //
        '('#13#10 + //
        '  SELECT LOJA_ID, TERMINAL_ID, LOG_ID, DTH'#13#10 + //
        '  FROM LOG'#13#10 + //
        ')'#13#10 + //
        'SELECT'#13#10 + //
        '  O.LOJA_ID'#13#10 + // //
        '  , O.TERMINAL_ID'#13#10 + // //
        '  , O.SESS_ID AS ID'#13#10 + // //
        '  , O.OPER_LOG_ID AS LOG_ID'#13#10 + //
        '  , O.OPER_ORDEM AS ORDEM'#13#10 + //
        '  , O.OPER_TIPO_ID AS TIPO_ID'#13#10 + //
        '  , T.NAME AS TIPO_STR'#13#10 + //
        '  , L.DTH AS CRIADO_EM'#13#10 + //
        '  , O.VALOR'#13#10 + //
        '  , O.CANCELADO'#13#10 + //
        '  , ''01.01.1900'' AS CANCELADO_EM'#13#10 + //
        '  , O.OBS'#13#10 + //
        'FROM T'#13#10 + //
        'JOIN O'#13#10 + //
        '  ON T.OPER_TIPO_ID = O.OPER_TIPO_ID'#13#10 + //
        'JOIN L'#13#10 + //
        '  ON O.LOJA_ID = L.LOJA_ID'#13#10 + //
        '  AND O.TERMINAL_ID = L.TERMINAL_ID'#13#10 + //
        '  AND O.OPER_LOG_ID = L.LOG_ID'#13#10 + //
        ';';

      // {$IFDEF DEBUG}
      // CopyTextToClipboard(sSql);
      // {$ENDIF}

      oDBQuery := DBQueryCreate('CxOperaca.formapag.lista.get.q', DBConnection,
        sSql, nil, nil);

      oDBQuery.Abrir;
      q := oDBQuery.DataSet;
      while not q.Eof do
      begin
        t.Append;
        t.FieldByName('LOJA_ID').AsInteger := q.FieldByName('LOJA_ID')
          .AsInteger;
        t.FieldByName('TERMINAL_ID').AsInteger := q.FieldByName('TERMINAL_ID')
          .AsInteger;
        t.FieldByName('ID').AsInteger := q.FieldByName('ID').AsInteger;
        t.FieldByName('LOG_ID').AsLargeInt := q.FieldByName('LOG_ID')
          .AsLargeInt;
        t.FieldByName('ORDEM').AsInteger := q.FieldByName('ORDEM').AsInteger;
        t.FieldByName('TIPO_ID').AsString := q.FieldByName('TIPO_ID').AsString;
        t.FieldByName('TIPO_STR').AsString := q.FieldByName('TIPO_STR')
          .AsString;
        t.FieldByName('CRIADO_EM').AsDateTime := q.FieldByName('CRIADO_EM')
          .AsDateTime;
        t.FieldByName('VALOR').AsCurrency := q.FieldByName('VALOR').AsCurrency;
        t.FieldByName('CANCELADO').AsBoolean := q.FieldByName('CANCELADO')
          .AsBoolean;
        t.FieldByName('OBS').AsString := q.FieldByName('OBS').AsString;

        t.FieldByName('COD_STR').AsString :=
          Sis.Entities.Types.GetCod(t.FieldByName('LOJA_ID').AsInteger,
          t.FieldByName('TERMINAL_ID').AsInteger, t.FieldByName('ID').AsInteger,
          'CX') + '-' + t.FieldByName('ORDEM').AsInteger.ToString;

        pDMemTable1.Post;
        oDBQuery.DataSet.Next;
      end;

      sSql := 'WITH E AS'#13#10 + //
        '('#13#10 + //
        '  SELECT LOJA_ID, TERMINAL_ID, EST_MOV_ID, CRIADO_EM,'#13#10 + //
        '  CANCELADO, CANCELADO_EM'#13#10 + //
        '  FROM EST_MOV'#13#10 + //
        '  WHERE FINALIZADO'#13#10 + //
        '), V AS'#13#10 + //
        '('#13#10 + //
        '  SELECT LOJA_ID, TERMINAL_ID, EST_MOV_ID, VENDA_ID,'#13#10 + //
        '  TOTAL_LIQUIDO'#13#10 + //
        '  FROM VENDA'#13#10 + //
        '  WHERE LOJA_ID = ' + pCaixaSessao.LojaId.ToString + #13#10 + //
        '  AND TERMINAL_ID = ' + pCaixaSessao.TerminalId.ToString + #13#10 +
      //
        '  AND SESS_ID = ' + pCaixaSessao.Id.ToString + #13#10 + //
        ')'#13#10 + //
        'SELECT'#13#10 + //
        '  E.LOJA_ID'#13#10 + //
        '  , E.TERMINAL_ID'#13#10 + //
        '  , E.EST_MOV_ID AS ID'#13#10 + //
        '  , -1 AS LOG_ID'#13#10 + //
        '  , 0 AS ORDEM'#13#10 + //
        '  , ''*'' AS TIPO_ID'#13#10 + //
        '  , ''VENDA'' AS TIPO_STR'#13#10 + //
        '  , E.CRIADO_EM'#13#10 + //
        '  , V.TOTAL_LIQUIDO AS VALOR'#13#10 + //
        '  , E.CANCELADO'#13#10 + //
        '  , E.CANCELADO_EM'#13#10 + //
        '  , '''' AS OBS'#13#10 + //
        'FROM E'#13#10 + //
        'JOIN V'#13#10 + //
        '  ON E.LOJA_ID = V.LOJA_ID'#13#10 + //
        '  AND E.TERMINAL_ID = V.TERMINAL_ID'#13#10 + //
        '  AND E.EST_MOV_ID = V.EST_MOV_ID'#13#10 + //
        ';';

      // {$IFDEF DEBUG}
      // CopyTextToClipboard(sSql);
      // {$ENDIF}
      oDBQuery := DBQueryCreate('CxOperaca.formapag.lista.get.q', DBConnection,
        sSql, nil, nil);

      oDBQuery.Abrir;
      q := oDBQuery.DataSet;
      while not q.Eof do
      begin
        t.Append;
        t.FieldByName('LOJA_ID').AsInteger := q.FieldByName('LOJA_ID')
          .AsInteger;
        t.FieldByName('TERMINAL_ID').AsInteger := q.FieldByName('TERMINAL_ID')
          .AsInteger;
        t.FieldByName('ID').AsInteger := q.FieldByName('ID').AsInteger;
        t.FieldByName('LOG_ID').AsLargeInt := q.FieldByName('LOG_ID')
          .AsLargeInt;
        t.FieldByName('ORDEM').AsInteger := q.FieldByName('ORDEM').AsInteger;
        t.FieldByName('TIPO_ID').AsString := q.FieldByName('TIPO_ID').AsString;
        t.FieldByName('TIPO_STR').AsString := q.FieldByName('TIPO_STR')
          .AsString;
        t.FieldByName('CRIADO_EM').AsDateTime := q.FieldByName('CRIADO_EM')
          .AsDateTime;
        t.FieldByName('VALOR').AsCurrency := q.FieldByName('VALOR').AsCurrency;
        t.FieldByName('CANCELADO').AsBoolean := q.FieldByName('CANCELADO')
          .AsBoolean;
        t.FieldByName('OBS').AsString := q.FieldByName('OBS').AsString;

        t.FieldByName('COD_STR').AsString :=
          Sis.Entities.Types.GetCod(t.FieldByName('LOJA_ID').AsInteger,
          t.FieldByName('TERMINAL_ID').AsInteger,
          t.FieldByName('ID').AsInteger, 'VEN');

        pDMemTable1.Post;
        oDBQuery.DataSet.Next;
      end;
    finally
      oDBQuery.Fechar;
      pDMemTable1.First;
      pDMemTable1.EndBatch;

      with pDMemTable1.Indexes.Add do
      begin
        Name := 'IdxCriadoEm';
        Fields := 'CRIADO_EM';
        Active := True;
      end;

      pDMemTable1.IndexesActive := True;
      pDMemTable1.IndexName := 'IdxCriadoEm';

      // pDMemTable1.AddIndex( 'IdxCriadoEm', 'CRIADO_EM', '', [], '', '');
      // pDMemTable1.IndexName := 'IdxCriadoEm';
      // pDMemTable1.Indexes.Add.Active := True;
      pDMemTable1.EnableControls;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TCaixaSessaoDBI.PreenchaCxSessRelatorio(pLinhas: TStrings;
  pCaixaSessao: ICaixaSessao);
begin

end;

end.
