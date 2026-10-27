import sys
import pytest
from polyforge.geometry import blender_export,freecad_export,preview_export,photogrammetry

@pytest.mark.parametrize('backend',[blender_export,freecad_export,preview_export,photogrammetry])
def test_native_console_utf8_and_invalid_bytes_do_not_break_export_reporting(backend):
    text='中文 • native fixture'
    if backend is blender_export:
        text=backend.START_MARKER+'\n'+text+'\n'+backend.END_MARKER
    command=[sys.executable,'-c',f"import sys;sys.stdout.buffer.write({text!r}.encode('utf8')+b'\\xff')"]
    output=backend.run(command)
    assert '中文 • native fixture' in output
    assert '\ufffd' in output
