unit Sis.UI.Decorator.Form;

interface

uses Sis.UI.Decorator;

type
  IDecoratorForm = interface(IDecorator)
    ['{02CD8B88-C5F2-4BAD-B791-4BEB114282B6}']
    procedure FormShow(Sender: TObject);
    function GetCaption: string;
  end;

implementation

end.
