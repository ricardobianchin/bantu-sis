unit Sis.UI.IO.Files.PasI;

interface

uses System.Classes;

procedure PreenchaEnumValues(pPasFileName: string; pEnumName: string; pPossibleValues: TStrings);

implementation

uses
  System.SysUtils, System.RegularExpressions;

procedure PreenchaEnumValues(pPasFileName: string; pEnumName: string; pPossibleValues: TStrings);
var
  FileContent: TStringList;
  EnumRegex: TRegEx;
  Match: TMatch;
begin
  FileContent := TStringList.Create;
  try
    FileContent.LoadFromFile(pPasFileName);
    EnumRegex := TRegEx.Create(Format('\b%s\s*=\s*\((.*?)\)', [pEnumName]), [roSingleLine]);
    Match := EnumRegex.Match(FileContent.Text);
    if Match.Success then
    begin
      pPossibleValues.Delimiter := ',';
      pPossibleValues.DelimitedText := Match.Groups[1].Value;
    end;
  finally
    FileContent.Free;
  end;
end;

end.
