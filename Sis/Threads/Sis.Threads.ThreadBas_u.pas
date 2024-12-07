unit Sis.Threads.ThreadBas_u;

interface

uses System.Classes, Sis.Threads.SafeBool;

type
  TThreadBas = class(TThread)
  private
    FThreadTitulo: string;
//    FExecutandoSafeBool: ISafeBool;

//    function GetExecutando: boolean;
  protected
    property ThreadTitulo: string read FThreadTitulo write FThreadTitulo;
  //  procedure SetExecutando(const Value: boolean);
  public
    constructor Create(//pExecutandoSafeBool: ISafeBool;
      pThreadTitulo: string = '');
//    property Executando: boolean read GetExecutando;//é read-only. só a thread pode alterá-la
  end;

implementation

{ TThreadBas }

uses Sis.Types.strings_u;

constructor TThreadBas.Create(//pExecutandoSafeBool: ISafeBool;
  pThreadTitulo: string);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  //FExecutandoSafeBool := pExecutandoSafeBool;
//  SetExecutando(False);

  if pThreadTitulo = '' then
    FThreadTitulo := ClassNameToNome(ClassName)
  else
    FThreadTitulo := pThreadTitulo;
end;

//function TThreadBas.GetExecutando: boolean;
//begin
//  Result := FExecutandoSafeBool.AsBoolean;
//end;
//
//procedure TThreadBas.SetExecutando(const Value: boolean);
//begin
//  FExecutandoSafeBool.AsBoolean := Value;
//end;

end.
