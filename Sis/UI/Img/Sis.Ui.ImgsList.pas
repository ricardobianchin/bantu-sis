unit Sis.Ui.ImgsList;

interface

type
  IImgsList = interface(IInterface)
    ['{7B217C66-0A0A-4B6E-BE9A-06C61F4013D0}']
    function PegueImgIndex(pFileName: string): integer;
    function ImgIndexToFileName(pImgIndex: integer): string;
  end;

implementation

end.
