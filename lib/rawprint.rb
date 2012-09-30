class RawPrinter
  attr_reader :printerName, :portName

  def initialize(printerName, portName)
    @printerName = printerName
    @portName = portName

    #FPrnHandle := StartRawPrintJob(PChar(PrinterName), PChar(PortName),
    #                               'TWinRawPrinter Document');
    #if Integer(FPrnHandle) < 0 then
    #  raise ERawPrinterException.Create('StartRawPrintJob failed');
    #
    #if StartRawPrintPage(FPrnHandle) < 0 then begin
    #  EndRawPrintJob(FPrnHandle);
    #  raise ERawPrinterException.Create('StartRawPrintPage failed');
    #end;
  end
end

=begin
{$A+,B-,E+,F-,I+,N-,R-,S+,V-}
type
    ERawPrinterException = class(Exception);

    TWinRawPrinter = class
      protected
        FPrnHandle : THandle;
      public
        constructor Create(const PrinterName, PortName : string);
        destructor Destroy; override;
        procedure LineFeed;
        procedure FormFeed;
        procedure WriteBuf(P : Pointer; BufLen : Integer);
        procedure Write(const S : Ansistring);
        procedure WriteLn(const S : Ansistring);
        property PrnHandle : THandle read FPrnHandle;
      end;

procedure AssignRawPrn(var F : Text);
  {-Sets up a text file device driver for sending raw data to the current Windows
    printer}

implementation

uses
  Printers, PrtRaw;

procedure TWinRawPrinter.LineFeed;
const
  ctCRLF : array[1..2] of AnsiChar = (#13, #10);
begin
  WriteBuf(@ctCRLF, SizeOf(ctCRLF));
end;  { LineFeed }

procedure TWinRawPrinter.FormFeed;
const
  ctFF : AnsiChar = #12;
begin
  WriteBuf(@ctFF, SizeOf(ctFF));
end;  { FormFeed }

procedure TWinRawPrinter.WriteBuf(P : Pointer; BufLen : Integer);
begin
  PrintRawData(FPrnHandle, P, BufLen);
end;  { WriteBuf }

procedure TWinRawPrinter.Write(const S : Ansistring);
begin
  WriteBuf(@S[1], Length(S));
end;  { Write }

procedure TWinRawPrinter.WriteLn(const S : Ansistring);
begin
  Write(S);
  LineFeed;
end;  { WriteLn }



const
  {This does NOT limit the length of strings that can be printed using the text
   file device driver. Strings longer than 256 chars can safely be printed.}
  ctRawPrnBufSize = 256;
type
  TRawPrnBuffer = array[0..ctRawPrnBufSize-1] of Char;
var
  RawPrnBuffer  : TRawPrnBuffer;
  WinRawPrinter : TWinRawPrinter = nil;

function RawPrnInput(var F: TTextRec): Integer;
  {-Called when a Read or Readln is applied to a printer file. Since reading is
    illegal this routine tells the I/O system that no characters were read,
    which generates a runtime error.}
begin
  with F do begin
    BufPos := 0;
    BufEnd := 0;
  end;
  Result := 0;
end;  { RawPrnInput }

function RawPrnOutput(var F: TTextRec): Integer;
  {-Called when a Write or Writeln is applied to a printer file. Sends the raw
    data directly to the printer via the WinRawPrinter.}
begin
  WinRawPrinter.WriteBuf(F.BufPtr, F.BufPos);
  F.BufPos := 0;
  Result   := 0;
end;  { RawPrnOutput }

function RawPrnIgnore(var F: TTextRec): Integer;
  {-Will ignore certain requests by the I/O system such as flush while doing an
    input. }
begin
  Result := 0;
end;  { RawPrnIgnore }

function RawPrnClose(var F: TTextRec): Integer;
  {-Destroys the TWinRawPrinter that was created by RawPrnOpen}
begin
  WinRawPrinter.Free;
  WinRawPrinter := nil;
  Result := 0;
end;  { RawPrnClose }

function RawPrnOpen(var F: TTextRec): Integer;
  {-If opening for output (Rewrite or Append), creates the WinRawPrinter that
    will be used for sending raw data to the printer}
var
  Device     : array[0..cchDeviceName-1] of Char;
  DriverName : array[0..MAX_PATH-1] of Char;
  Port       : array[0..32] of Char;
  DevHandle  : THandle;
begin
  with F do
    if Mode = fmInput then begin
      {Reading is illegal. RawPrnInput will cause a runtime error when it is
       called by Read or ReadLn.}
      InOutFunc := @RawPrnInput;
      FlushFunc := @RawPrnIgnore;
      CloseFunc := @RawPrnIgnore;
    end else begin
      {If Append was called, Mode will be fmInOut. Must be changed to fmOutput
       before exiting.}
      Mode      := fmOutput;
      InOutFunc := @RawPrnOutput;
      FlushFunc := @RawPrnOutput;
      CloseFunc := @RawPrnClose;

      {Get the printer name and port name of the current printer}
      Printer.GetPrinter(Device, DriverName, Port, DevHandle);

      {Create a TWinRawPrinter using the name and port of the current printer}
      WinRawPrinter := TWinRawPrinter.Create(Device, Port);
    end;
  Result := 0;
end;  { RawPrnOpen }

procedure AssignRawPrn(var F : Text);
  {-Sets up a text file device driver for sending raw data to the current Windows
    printer}
begin
 with TTextRec(F) do begin
   Mode     := fmClosed;
   BufSize  := SizeOf(RawPrnBuffer);
   BufPtr   := @RawPrnBuffer;
   BufPos   := 0; {Omitted from Delphi Help example, but absolutely needed!}
   Name[0]  := #0;
   {Set the OpenFunc. Don't set InOutFunc, FlushFunc, or CloseFunc here because
    they will be set when the OpenFunc is called. That way they can be set to
    different functions depending on whether we're opening for output (rewrite
    or append) or input (reset).}
   OpenFunc := @RawPrnOpen;
 end;
end;  { AssignRawPrn }

end.
=end
