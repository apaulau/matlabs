function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',1);
set(ax,'DataAspectRatio',[1 0.97499999999999987 1]);
set(ax,'PlotBoxAspectRatio',[1.5384615384615388 1.0256410256410258 1.5384615384615388]);
set(ax,'XLimMode','auto');
set(ax,'YLimMode','auto');
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');
pdetool('gridon','on');

% Geometry description:
pdepoly([ 1,...
 1,...
 1.1000000000000001,...
 1.1000000000000001,...
 1.3999999999999999,...
 1.3999999999999999,...
 1.8,...
 1.8,...
 2.1000000000000001,...
 2.1000000000000001,...
 2.6000000000000001,...
 2.6000000000000001,...
 3,...
 3,...
],...
[ 1,...
 2.2999999999999998,...
 2.2999999999999998,...
 1.3,...
 1.3,...
 2.2999999999999998,...
 2.2999999999999998,...
 1.3,...
 1.3,...
 2.2999999999999998,...
 2.2999999999999998,...
 1.3,...
 1.3,...
 1,...
],...
 'P1');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','P1')

% Boundary conditions:
pdetool('changemode',0)
pdesetbd(14,...
'dir',...
1,...
'1',...
'(x.^2)*sin(2.6)')
pdesetbd(13,...
'dir',...
1,...
'1',...
'(x.^2)*sin(2.6)')
pdesetbd(12,...
'dir',...
1,...
'1',...
'(x.^2)*sin(2.6)')
pdesetbd(11,...
'dir',...
1,...
'1',...
'(x.^2)*sin(4.6)')
pdesetbd(10,...
'dir',...
1,...
'1',...
'(x.^2)*sin(4.6)')
pdesetbd(9,...
'dir',...
1,...
'1',...
'(x.^2)*sin(4.6)')
pdesetbd(8,...
'dir',...
1,...
'1',...
'(x.^2)*sin(2)')
pdesetbd(7,...
'neu',...
1,...
'0',...
'-6*sin(2*y)')
pdesetbd(6,...
'neu',...
1,...
'0',...
'-5.2*sin(2*y)')
pdesetbd(5,...
'neu',...
1,...
'0',...
'3.2*sin(2*y)')
pdesetbd(4,...
'neu',...
1,...
'0',...
'-3.6*sin(2*y)')
pdesetbd(3,...
'neu',...
1,...
'0',...
'2.8*sin(2*y)')
pdesetbd(2,...
'neu',...
1,...
'0',...
'-2.2*sin(2*y)')
pdesetbd(1,...
'neu',...
1,...
'0',...
'2*sin(2*y)')

% Mesh generation:
setappdata(pde_fig,'Hgrad',1.3);
setappdata(pde_fig,'refinemethod','regular');
setappdata(pde_fig,'jiggle',char('on','mean',''));
setappdata(pde_fig,'MesherVersion','preR2013a');
pdetool('initmesh')
pdetool('refine')
pdetool('refine')

% PDE coefficients:
pdeseteq(1,...
'-1.0',...
'0.0',...
'2*(1-2*(x.^2)).*sin(2*y)',...
'1.0',...
'0:10',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['-1.0                    ';...
'0.0                     ';...
'2*(1-2*(x.^2)).*sin(2*y)';...
'1.0                     '])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
char('0','3648','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[4 1 1 1 1 1 8 1 0 0 0 1 1 1 0 0 0 1]);
setappdata(pde_fig,'colstring','(u-((x.^2).*sin(2*y)))./((x.^2).*sin(2*y))');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');

% Solve PDE:
pdetool('solve')
