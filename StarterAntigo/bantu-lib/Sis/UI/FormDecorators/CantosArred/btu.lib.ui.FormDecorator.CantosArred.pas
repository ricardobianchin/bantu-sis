unit btu.lib.ui.FormDecorator.CantosArred;

interface

uses btu.lib.ui.FormDecorator, forms;

type
  /// <summary>
  ///   insere cantos arredondados no form
  /// </summary>
  TCantosArredDecorator = class(TInterfacedObject, IFormDecorator)
  private
    FForm: TForm;
    function GetForm: TObject;
    procedure SetForm(const Value: TObject);
  public
    procedure FormCreate;
    procedure FormDestroy;
    procedure FormSize;
    procedure FormKeyPress(var Key: Char);
    procedure FormCaptionChanged(pNovaCaption: string);

    property Form: TObject read GetForm write SetForm;
  end;

implementation

uses System.SysUtils;

{ TRoundCornersDecorator }

procedure TCantosArredDecorator.FormCaptionChanged(pNovaCaption: string);
begin

end;

procedure TCantosArredDecorator.FormCreate;
begin

end;

procedure TCantosArredDecorator.FormDestroy;
begin

end;

procedure TCantosArredDecorator.FormKeyPress(var Key: Char);
begin

end;

procedure TCantosArredDecorator.FormSize;
begin

end;

function TCantosArredDecorator.GetForm: TObject;
begin
  result := FForm;
end;

procedure TCantosArredDecorator.SetForm(const Value: TObject);
begin
  if not Value.ClassType.InheritsFrom(TForm) then
    raise Exception.Create('Erro '+value.ClassName +' não é descendente de TForm.');

  FForm := TForm(Value);
end;

end.
