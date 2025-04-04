unit TestForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask;

type
  TTestForm = class(TForm)
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Label1: TLabel;
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TestForm: TTestForm;

implementation

{$R *.dfm}

procedure TTestForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  oControleSeguinte: TWinControl;
  oForm: TForm;
begin
  oControleSeguinte := MaskEdit2;
  // o sender é o form, para isto, liguei KeyPreview
  oForm := TForm(Sender);
  if ActiveControl = oControleSeguinte then
  begin
    if Key = VK_TAB then
    begin
      Label1.Caption := 'The [Tab] key was pressed';
    end;
  end;
end;

procedure TTestForm.MaskEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Label1.Caption := TWinControl(Sender).Name;
  if key = VK_RETURN then
    Label1.Caption := 'The [Enter] key was pressed';
end;

end.
