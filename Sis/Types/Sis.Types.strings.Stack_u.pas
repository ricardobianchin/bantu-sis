unit Sis.Types.strings.Stack_u;

interface

uses Sis.Types.strings.Stack, System.Generics.Collections;

const
  STACK_SEPARADOR = ' / ';

type
  TStrStack = class(TInterfacedObject, IStrStack)
  private
    FStack: TStack<string>; // usa uma pilha gen�rica de strings
    function GetCaminho: string;
  public
    procedure Push(const Value: string);
    procedure Pop(out Value: string); overload;
    function Pop: string; overload;

    property Caminho: string read GetCaminho;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses Sis.Types.Utils_u;

constructor TStrStack.Create;
begin
  inherited;
  FStack := TStack<string>.Create; // cria uma pilha vazia
end;

destructor TStrStack.Destroy;
begin
  FStack.Free; // libera a mem�ria da pilha
  inherited;
end;

function TStrStack.Pop: string;
begin
  Pop(Result);
end;

procedure TStrStack.Push(const Value: string);
begin
  FStack.Push(Value); // empilha o valor na pilha
end;

procedure TStrStack.Pop(out Value: string);
begin
  if FStack.Count > 0 then // verifica se a pilha n�o est� vazia
    Value := FStack.Pop // desempilha o valor e atribui ao par�metro
  else
    Value := STR_NULA; // retorna uma string vazia se a pilha estiver vazia
end;

function TStrStack.GetCaminho: string;
var
  I: Integer;
begin
  Result := ''; // inicializa o resultado como uma string vazia
//  for I := FStack.Count - 1 downto 0 do // percorre os elementos da propriedade List em ordem inversa
  for I := 0 to FStack.Count - 1 do // percorre os elementos da propriedade List
  begin
    Result := Result + FStack.List[I] + STACK_SEPARADOR; // concatena o elemento com uma v�rgula no resultado
  end;
//  Delete(Result, Length(Result) - (Lenght(STACK_SEPARADOR) - 1),
//    Lenght(STACK_SEPARADOR)); // remove a �ltima v�rgula do resultado
end;

end.
