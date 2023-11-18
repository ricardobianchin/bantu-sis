unit Sis.Types.strings.Stack_u;

interface

uses Sis.Types.strings.Stack, System.Generics.Collections;

type
  TStrStack = class(TInterfacedObject, IStrStack)
  private
    FStack: TStack<string>; // usa uma pilha genérica de strings
  public
    procedure Push(const Value: string);
    procedure Pop(out Value: string);
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
  FStack.Free; // libera a memória da pilha
  inherited;
end;

procedure TStrStack.Push(const Value: string);
begin
  FStack.Push(Value); // empilha o valor na pilha
end;

procedure TStrStack.Pop(out Value: string);
begin
  if FStack.Count > 0 then // verifica se a pilha não está vazia
    Value := FStack.Pop // desempilha o valor e atribui ao parâmetro
  else
    Value := STR_NULA; // retorna uma string vazia se a pilha estiver vazia
end;

end.
