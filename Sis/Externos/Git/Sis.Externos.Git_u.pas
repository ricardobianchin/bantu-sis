unit Sis.Externos.Git_u;

interface

type
  TGit = class(TInterfacedObject, IGit)
  private
    function GetDescribe: string;
  public
    property Describe: string read GetDescribe;
  end;

implementation

uses Sis.Win.Factory, Sis.Types.Times;

//const
//  GIT_EXECUTEFILE = '"C:\Program Files\Git\git-bash.exe"';
//  GIT_COMMAND = 'git';
//  GIT_PARAM_DESCRIBE = 'describe';
//  CONTROLE_PASTA = 'C:\Pr\app\bantu\bantu-sis\Controle\';

{ TGit }

function TGit.GetDescribe: string;
var
  sExecuteFile, sParams, sStartIn: string;
begin
  sExecuteFile := GIT_COMMAND
  sParams := GIT_PARAM_DESCRIBE;
  sStartIn := CONTROLE_PASTA;

  WinExecuteComando(
end;

end.
