unit Btu.UI.Controls.NumericEdit;

interface

uses
  SysUtils, Classes, Btu.UI.Controls.Edit.Numeric.Custom_u, ExtCtrls;

type
  TBtuNumEdit = class(TCustomBtuNumEdit)
  private
    { Private declarations }
  protected
//    procedure DoExit; override;
    { Protected declarations }
  public
    { Public declarations }
    property AutoExit;


  published
    { Published declarations }

    property Caption;
    property EditLabel;

    property Anchors;
    property AutoSelect default true;
    property AutoSize;
//    property BevelEdges;
//    property BevelInner;
//    property BevelKind;
//    property BevelOuter;
//    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
//    property Constraints;
    property Ctl3D;
//    property DragCursor;
//    property DragKind;
//    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
//    property ImeMode;
//    property ImeName;
    property LabelPosition default lpAbove;
    property LabelSpacing default 1;
    property MaxLength;
//    property OEMConvert;
//    property ParentBiDiMode;
    property ParentColor;
//    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
//    property OnDblClick;
//    property OnDragDrop;
//    property OnDragOver;
//    property OnEndDock;
//    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
//    property OnStartDock;
//    property OnStartDrag;

    property NCasas;
    property NCasasEsq;
    property Valor;
    property MascEsq;
    property CharDecimal;
  end;

procedure Register;

implementation

uses Graphics;

procedure Register;
begin
  RegisterComponents('BtuControls', [TBtuNumEdit]);
end;

{ TBtuNumEdit }

end.
