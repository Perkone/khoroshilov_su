library khoroshilov_su.components.webgl.webgl;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'dart:html';
import 'dart:web_gl';
import 'dart:typed_data';
import 'package:khoroshilov_su/utils.dart';

@Component(
    selector: 'webgl-cmp',
    templateUrl: 'webgl.html',
    styleUrls: const ['webgl.css'],
    directives: const []
)
class WebGLCmp implements AfterViewInit, OnActivate {

  ElementRef _host;

  Element get host => (_host.nativeElement as HtmlElement);

  WebGLCmp(this._host);

  routerOnActivate(next, prev) {
    changeTitle('WebGL | Хорошилов А.С.');
  }

  ngAfterViewInit() {
    webglStart();
  }

  //int timeDelta;
  List<double> myColor;
  Stopwatch stopwatch;

  int get timeDelta => stopwatch.elapsedMilliseconds;

  webglStart() {
    CanvasElement canvas = new CanvasElement();
    canvas.width = host.clientWidth;
    canvas.height = host.clientHeight;
    canvas.style.width = '${canvas.width}px';
    canvas.style.height = '${canvas.height}px';
    host.append(canvas);

    //Берём webGl контекст для вывода графики
    RenderingContext gl = canvas.getContext3d();
    if (gl == null) {
      print('Can\'t get 3D context.');
      return;
    }

    stopwatch = new Stopwatch()
      ..start();
    myColor = [1.0, 0.0, 0.0];

    _resizeCanvas(canvas);

//    window.onResize.listen((event) {
//      _resizeCanvas(canvas);
//    });

    Program p = _prepareWebGLProgram(gl, _vsSource, _fsSource);
    _prepareRenderData(gl, p, _vertices);

    //Очищаем холст заливая его новым цветом(RedGreenBlueAlpha)
    gl.clearColor(0.8, 0.8, 0.8, 1);
    gl.clear(RenderingContext.COLOR_BUFFER_BIT);


    UniformLocation uTimeLocation = gl.getUniformLocation(p, "uTime");

    void drawScene() {
      gl.uniform1i(uTimeLocation, timeDelta);
      gl.drawArrays(RenderingContext.TRIANGLES, 0, 6);
    }

    void render() {
      window.requestAnimationFrame((callback) {
        render();
      });

      drawScene();
    }

    render();
  }

  void _resizeCanvas(CanvasElement canvas) {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    canvas.getContext3d().viewport(0, 0, canvas.width, canvas.height);
  }

  Program _prepareWebGLProgram(RenderingContext gl, String vsSource,
      String fsSource) {
    //Шейдеры написаны, теперь их надо скомпилировать и загрузить в контекст.
    //Компилируем
    Shader vs = gl.createShader(RenderingContext.VERTEX_SHADER);
    gl.shaderSource(vs, vsSource);
    gl.compileShader(vs);
    Shader fs = gl.createShader(RenderingContext.FRAGMENT_SHADER);
    gl.shaderSource(fs, fsSource);
    gl.compileShader(fs);

    // Загружаем шейдеры в GPU
    Program p = gl.createProgram();
    gl.attachShader(p, vs);
    gl.attachShader(p, fs);
    gl.linkProgram(p);
    gl.useProgram(p);

    //Проверяем всё ли удачно скомпилировалось.
    if (!gl.getShaderParameter(vs, RenderingContext.COMPILE_STATUS)) {
      print(gl.getShaderInfoLog(vs));
    }

    if (!gl.getShaderParameter(fs, RenderingContext.COMPILE_STATUS)) {
      print(gl.getShaderInfoLog(fs));
    }

    if (!gl.getProgramParameter(p, RenderingContext.LINK_STATUS)) {
      print(gl.getProgramInfoLog(p));
    }

    gl.deleteShader(vs);
    gl.deleteShader(fs);

    return p;
  }

  void _prepareRenderData(RenderingContext gl, Program p,
      Float32List vertices) {
    gl.bindBuffer(RenderingContext.ARRAY_BUFFER, gl.createBuffer());
    gl.bufferData(
        RenderingContext.ARRAY_BUFFER, new Float32List.fromList(vertices),
        RenderingContext.DYNAMIC_DRAW);

    int aVertexPositionLocation = gl.getAttribLocation(p, "aVertexPosition");
    gl.enableVertexAttribArray(aVertexPositionLocation);
    gl.vertexAttribPointer(
        aVertexPositionLocation, 2, RenderingContext.FLOAT, false, 0, 0);

    UniformLocation uResolutionLocation = gl.getUniformLocation(
        p, "uResolution");
    gl.uniform2i(uResolutionLocation, gl.canvas.width, gl.canvas.height);

    UniformLocation uTimeLocation = gl.getUniformLocation(p, "uTime");
    gl.uniform1i(uTimeLocation, timeDelta);

    UniformLocation uColorLocation = gl.getUniformLocation(p, "uColor");
    gl.uniform3fv(uColorLocation, new Float32List.fromList(myColor));
  }

  String get _vsSource =>
      '''
attribute vec2 aVertexPosition;

void main()
{
  gl_Position = vec4(aVertexPosition, 1, 1);
}
    ''';

  String get _fsSource =>
      '''
precision mediump float;

const float PI = 3.14159265259;

uniform ivec2 uResolution;
uniform int uTime;
uniform vec3 uColor;

float random(float p) {
  return fract(sin(p) * 500.);
}

float noise(vec2 p) {
  float t = float(uTime) / 1000.;

  if (t > 1.)
    t -= floor(t);

  return random(p.x * 1000. + p.y * sin(t) * .1);
}

void main() {
  vec2 position = gl_FragCoord.xy / vec2(uResolution).xy;

//  float wave = fract(10000. * sin(8. * 2. * PI * (128. * position.x + 1024. * position.y)));

//  wave = (wave + 1.) / 2.;

//  vec3 col = vec3(.2, .1, .643) * noise(position);
  vec3 col = vec3(0, 0.7, 0) * noise(position);

  gl_FragColor = vec4(vec3(col), 1);
}
    ''';

  List<double> get _vertices => [
    -1.0, 1.0,
    1.0, 1.0,
    1.0, -1.0,

    1.0, -1.0,
    -1.0, -1.0,
    -1.0, 1.0
  ];

}
