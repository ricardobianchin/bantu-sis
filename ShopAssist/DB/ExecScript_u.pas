unit ExecScript_u;

interface

uses
  FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, System.Classes, Data.DB,
  FireDAC.Stan.Async, Sis.Types, System.Generics.Collections;

type
  TExecScript = class(TObject)
  private
    FUltimoErro: string;
    FConnection: TFDConnection;
    FFDCommand: TFDCommand;
    FSql: TStringList;

    function GetSQL: TStrings;
    procedure SalveComandos;
  protected
    property UltimoErro: string read FUltimoErro write FUltimoErro;
  public
    procedure PegueComando(pComando: string);
    procedure Execute;
    constructor Create(pConnection: TFDConnection);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u;

{ TExecScript }

constructor TExecScript.Create(pConnection: TFDConnection);
begin
  FConnection := pConnection;
  FFDCommand := TFDCommand.Create(nil);
  FFDCommand.Connection := FConnection;
  FSql := TStringList.Create;
end;

destructor TExecScript.Destroy;
begin
  FreeAndNil(FFDCommand);
  FreeAndNil(FSql);
  inherited;
end;

procedure TExecScript.Execute;
var
  iQtdCommands: integer;
  sComando: string;
begin
  SalveComandos;
  FConnection.StartTransaction;
  try
    iQtdCommands := 0;
    for var i := 0 to FSql.Count - 1 do
    begin
      sComando := FSql[i];
      FFDCommand.CommandText.Text := sComando;
      FFDCommand.Execute;

      inc(iQtdCommands);
      if (iQtdCommands mod 333) = 0 then
        Sleep(5);
    end;
    FConnection.Commit;
    FSql.Clear;
  except
    on E: Exception do
    begin
      UltimoErro := 'TDBExecScriptFireDac.Execute Erro'#13#10#13#10
        + E.classname + #13#10
        + E.message + #13#10
        + #13#10
        + 'ao tentar executar:'#13#10
        + '-------'#13#10
        + sComando + #13#10'-------'#13#10
        + sComando + #13#10
        //+ 'Conexao='
//        + DBConnection.Nome + #13#10'Componente=' + Nome
        ;
      FConnection.Rollback;
      raise Exception.Create(UltimoErro);
    end;
  end;
end;

function TExecScript.GetSQL: TStrings;
begin
  Result := FSql;
end;

procedure TExecScript.PegueComando(pComando: string);
var
  UltimoChar: char;
begin
  pComando := Trim(pComando);
  if pComando = '' then
    exit;

  StrDeleteTrailingChars(pComando, [#9, #32, #10, #13]);
  StrGarantirTermino(pComando, ';');
  FSql.Add(pComando);
end;

procedure TExecScript.SalveComandos;
var
  sPasta: string;
  sArq: string;
begin
{$IFNDEF DEBUG}
  exit;
{$ENDIF}

  sPasta := ParamStr(0);
  sPasta := ExtractFilePath(sPasta);
  sPasta := IncludeTrailingPathDelimiter(sPasta);
  sArq := sPasta + 'TExecScript.sql';
  FSql.SaveToFile(sArq);
end;

end.
