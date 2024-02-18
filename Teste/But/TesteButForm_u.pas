unit TesteButForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.StdCtrls;

type
  TTesteButForm = class(TForm)
    ImageList1: TImageList;
    ActionList1: TActionList;
    OkAction: TAction;
    CancAction: TAction;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure OkActionExecute(Sender: TObject);
    procedure CancActionExecute(Sender: TObject);
  private
    { Private declarations }
    //FlatButton1: TFlatButton;
  public
    { Public declarations }
  end;

var
  TesteButForm: TTesteButForm;

implementation

{$R *.dfm}

procedure TTesteButForm.CancActionExecute(Sender: TObject);
begin
  Label1.Caption := 'Cancel';
end;

procedure TTesteButForm.FormCreate(Sender: TObject);
begin
//  FlatButton1 := TFlatButton.Create(Self);
//  FlatButton1.Parent := Self;
//  FlatButton1.Width := 40;
//  FlatButton1.Height := 40;
//  FlatButton1.Action := OkAction;
end;

procedure TTesteButForm.OkActionExecute(Sender: TObject);
begin
  Label1.Caption := 'Ok';
end;

end.
