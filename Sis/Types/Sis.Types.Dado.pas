unit Sis.Types.Dado;

interface

{
Gere o codigo de uma unit que define e implementa uma classe chamada TDado
Gere o codigo de uma unit do delphi
que armazena um `FValue:variant`
possui propriedades que recebem valores e armazenam na value
e que retornam o valor de value convertidos aos dados das respectivas properties:
property Value: variant read GetValue write SetValue;
property AsString:  read GetAsString write SetAsString;
property AsInteger:  read GetAsInteger write SetAsInteger;
property AsBoolean:  read GetAsBoolean write SetAsBoolean;
property AsCurrency:  read GetAsCurrency write SetAsCurrency;



}

implementation

end.
