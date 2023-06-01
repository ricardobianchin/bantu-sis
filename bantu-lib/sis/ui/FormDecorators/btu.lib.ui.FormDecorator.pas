unit btu.lib.ui.FormDecorator;

interface

type
    /// <summary>
    /// introduces a new behavior into a TForm
    /// each of the methods are called by the respective method within the TForm
    /// </summary>
    IFormDecorator = interface(IInterface)
    ['{7277A526-3049-4705-BD71-09B7439B134F}']
    procedure FormCreate;
    procedure FormDestroy;
    procedure FormSize;
    procedure FormKeyPress(var Key: Char);
    procedure FormCaptionChanged(pNovaCaption: string);

    procedure SetForm(const Value: TObject);
    function GetForm: TObject;
    property Form: TObject read GetForm write SetForm;
  end;

implementation

end.
