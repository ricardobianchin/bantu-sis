unit App.UI.Decorator.Form.Excl;

interface

uses Sis.UI.Decorator.Form;

type
  IDecoratorExcl = interface(IDecoratorForm)
    ['{FA925D5C-7089-4A0A-BFA2-0A895746193A}']
    function GetValues: string;
    function GetPergunta: string;
  end;

implementation

end.
