unit App.DB.Term.EnviarTabela.UsuarioPodeOpcaoSis_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB {, Data.FmtBcd} ,
  Sis.Entities.Types, App.DB.Term.Registro.UsuarioPodeOpcaoSisList_u;

type
  TDBConnectionLocation = (loServ, loTerm);
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabUsuarioPodeOpcaoSis = class(TEnviarTabela)
  private
    Conn: array [TDBConnectionLocation] of IDBConnection;
    FTabelaNome: string;
    FInsDBExec: IDBExec;
    FDelDBExec: IDBExec;
    FTermList: TUsuarioPodeOpcaoSisList;
    procedure InicializeCommands;
    procedure LibereCommands;
    procedure PreencherTermList;
    procedure Compare;
    procedure Insira(pLOJA_ID: TLojaId; pPESSOA_ID: integer; pOPCAO_SIS_ID: integer);
    procedure ExcluaRestantes;
  public
    function Execute: boolean; override;
    constructor Create(pServ, pTerm: IDBConnection);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, Sis.DB.Factory, Sis.Win.Utils_u, App.DB.Term.Registro.UsuarioPodeOpcaoSis_u;

{ TEnvTabUsuarioPodeOpcaoSis }

procedure TEnvTabUsuarioPodeOpcaoSis.Compare;
var
  sSql: string;
  Q: TDataSet;
  i: integer;
begin
  sSql := 'SELECT LOJA_ID, PESSOA_ID, OPCAO_SIS_ID'#13#10 //
    +'FROM USUARIO_PODE_OPCAO_SIS'#13#10 //
    +'ORDER BY LOJA_ID, TERMINAL_ID, PESSOA_ID, OPCAO_SIS_ID'#13#10 //
    ;

  Conn[loServ].QueryDataSet(sSql, Q);
  try
    while not Q.Eof do
    begin
      i := FTermList.IndexOfValores(Q.Fields[0].AsInteger, Q.Fields[1].AsInteger, Q.Fields[2].AsInteger);
      if i = -1 then
      begin
        Insira(Q.Fields[0].AsInteger, Q.Fields[1].AsInteger, Q.Fields[2].AsInteger);
      end
      else
      begin
        FTermList.Delete(i);
      end;
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

constructor TEnvTabUsuarioPodeOpcaoSis.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'USUARIO_PODE_OPCAO_SIS';
  FTermList := TUsuarioPodeOpcaoSisList.Create;
end;

destructor TEnvTabUsuarioPodeOpcaoSis.Destroy;
begin
  FTermList.Free;
  inherited;
end;

procedure TEnvTabUsuarioPodeOpcaoSis.ExcluaRestantes;
var
  up: TUsuarioPodeOpcaoSis;
  i: integer;
begin
  for i := 0 to FTermList.Count - 1 do
  begin
    up := FTermList[i];
    FDelDBExec.Params[0].AsSmallInt := up.LOJA_ID;
    FDelDBExec.Params[1].AsInteger := up.PESSOA_ID;
    FDelDBExec.Params[2].AsInteger := up.OPCAO_SIS_ID;
    FDelDBExec.Execute;
  end;
end;

function TEnvTabUsuarioPodeOpcaoSis.Execute: boolean;
begin
  InicializeCommands;
  try
    PreencherTermList;
    Compare;
    ExcluaRestantes;
  finally
    LibereCommands;
  end;
end;

procedure TEnvTabUsuarioPodeOpcaoSis.InicializeCommands;
var
  sSql: string;
begin
  sSql := //
    'INSERT INTO USUARIO_PODE_OPCAO_SIS ('#13#10 //

    + 'LOJA_ID'#13#10 //
    + ', TERMINAL_ID'#13#10 //
    + ', PESSOA_ID'#13#10 //
    + ', OPCAO_SIS_ID'#13#10 //

    + ') VALUES (' //

    + ':LOJA_ID'#13#10 //
    + ', 0'#13#10 //
    + ', :PESSOA_ID'#13#10 //
    + ', :OPCAO_SIS_ID'#13#10 //

    + ');'#13#10 //
    ;

  FInsDBExec := DBExecCreate('upos.env.ins.exec', Conn[loTerm], sSql, nil, nil);
  FInsDBExec.Prepare;

  sSql := //
    'DELETE FROM USUARIO_PODE_OPCAO_SIS'#13#10 //

    + 'WHERE LOJA_ID = :LOJA_ID'#13#10 //
    + 'AND TERMINAL_ID = 0'#13#10 //
    + 'AND PESSOA_ID = :PESSOA_ID'#13#10 //
    + 'AND OPCAO_SIS_ID = :OPCAO_SIS_ID;'#13#10 //
    ;

  FDelDBExec := DBExecCreate('upos.env.del.exec', Conn[loTerm], sSql, nil, nil);
  FDelDBExec.Prepare;
end;

procedure TEnvTabUsuarioPodeOpcaoSis.Insira(pLOJA_ID: TLojaId; pPESSOA_ID,
  pOPCAO_SIS_ID: integer);
begin
  FInsDBExec.Params[0].AsSmallInt := pLOJA_ID;
  FInsDBExec.Params[1].AsInteger := pPESSOA_ID;
  FInsDBExec.Params[2].AsInteger := pOPCAO_SIS_ID;
  FInsDBExec.Execute;
end;

procedure TEnvTabUsuarioPodeOpcaoSis.LibereCommands;
begin
  FInsDBExec.Unprepare;
  FDelDBExec.Unprepare;
end;

procedure TEnvTabUsuarioPodeOpcaoSis.PreencherTermList;
var
  sSql: string;
  Q: TDataSet;
begin
  FTermList.Clear;

  sSql := 'SELECT LOJA_ID, PESSOA_ID, OPCAO_SIS_ID'#13#10 //
    +'FROM USUARIO_PODE_OPCAO_SIS'#13#10 //
    +'ORDER BY LOJA_ID, TERMINAL_ID, PESSOA_ID, OPCAO_SIS_ID'#13#10 //
    ;
  Conn[loTerm].QueryDataSet(sSql, Q);
  try
    while not Q.Eof do
    begin
      FTermList.Adicionar(Q.Fields[0].AsInteger, Q.Fields[1].AsInteger, Q.Fields[2].AsInteger);
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

end.
