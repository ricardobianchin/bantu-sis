unit Sis.UI.IO.Output.ProcessLog.Properties.Stack_u;

interface

uses Sis.UI.IO.Output.ProcessLog.Properties.Stack,
  Sis.UI.IO.Output.ProcessLog.Types, Sis.UI.IO.Output.ProcessLog.Properties,
  System.Generics.Collections;

type
  TProcessLogPropertiesStack = class(TInterfacedObject,
    IProcessLogPropertiesStack)
  private
    FStack: TStack<IProcessLogProperties>;
  public
    procedure PushProperties(pTipo: TProcessLogTipo;
      pAssunto: TProcessLogAssunto; pNome: TProcessLogNome);
    procedure PopProperties(out pTipo: TProcessLogTipo;
      out pAssunto: TProcessLogAssunto; out pNome: TProcessLogNome);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TProcessLogPropertiesStack }

uses Sis.UI.IO.Output.ProcessLog.Factory, Sis.Types.Utils_u;

constructor TProcessLogPropertiesStack.Create;
begin
  FStack := TStack<IProcessLogProperties>.Create;
end;

destructor TProcessLogPropertiesStack.Destroy;
begin
  FStack.Free;
  inherited;
end;

procedure TProcessLogPropertiesStack.PopProperties(out pTipo: TProcessLogTipo;
  out pAssunto: TProcessLogAssunto; out pNome: TProcessLogNome);
var
  LProperties: IProcessLogProperties;
begin
  if FStack.Count > 0 then
  begin
    LProperties := FStack.Pop;
    pTipo := LProperties.Tipo;
    pAssunto := LProperties.Assunto;
    pNome := LProperties.Nome;
  end
  else
  begin
    pTipo := TProcessLogTipo.lptNaoDefinido;
    pAssunto := STR_NULA;
    pNome := STR_NULA;
  end;
end;

procedure TProcessLogPropertiesStack.PushProperties(pTipo: TProcessLogTipo;
  pAssunto: TProcessLogAssunto; pNome: TProcessLogNome);
var
  LProperties: IProcessLogProperties;
begin
  LProperties := ProcessLogPropertiesCreate(pTipo, pAssunto, pNome);
  FStack.Push(LProperties);
end;

end.
