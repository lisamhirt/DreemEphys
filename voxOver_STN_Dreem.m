function [] = voxOver_STN_Dreem()

mainDIR = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\VTA_mesh';
cd(mainDIR)

mdir = dir;
mdir1 = {mdir.name};
mdir2 = mdir1(~ismember(mdir1,{'.', '..'}));

dataTab = table;

for mi = 1:length(mdir2)
    patTEMP = mdir2{mi};
    tempFile = load(patTEMP);
    tempFN = fieldnames(tempFile);

    % Use extendedObjectMesh on each brain area - uses inner fxn
    % Left
    lVTA.vertices = tempFile.(tempFN{1}).left.VTA.vertices;
    lVTA.faces = tempFile.(tempFN{1}).left.VTA.faces;
    lwSTN.v = tempFile.(tempFN{1}).left.STN.wholeSTN.vertices;
    lwSTN.f = tempFile.(tempFN{1}).left.STN.wholeSTN.faces;
    lmSTN.v = tempFile.(tempFN{1}).left.STN.STN_motor_left.vertices;
    lmSTN.f = tempFile.(tempFN{1}).left.STN.STN_motor_left.faces;
    llSTN.v = tempFile.(tempFN{1}).left.STN.STN_limbic_left.vertices;
    llSTN.f = tempFile.(tempFN{1}).left.STN.STN_limbic_left.faces;
    laSTN.v = tempFile.(tempFN{1}).left.STN.STN_associative_left.vertices;
    laSTN.f = tempFile.(tempFN{1}).left.STN.STN_associative_left.faces;

    mesh_VTA_L = extendedObjectMesh(lVTA.vertices, lVTA.faces);
    mesh_wSTN_L = extendedObjectMesh(lwSTN.v, lwSTN.f);
    mesh_mSTN_L = extendedObjectMesh(lmSTN.v, lmSTN.f);
    mesh_lSTN_L = extendedObjectMesh(llSTN.v, llSTN.f);
    mesh_aSTN_L = extendedObjectMesh(laSTN.v, laSTN.f);

    % Left- Output volumes from overlay
    [l_wSTNvolf, l_mSTNvolf, l_lSTNvolf, l_aSTNvolf] = getVOLover(lVTA, mesh_wSTN_L , mesh_mSTN_L, mesh_lSTN_L, mesh_aSTN_L);
    fraC(:) = [l_lSTNvolf, l_mSTNvolf, l_wSTNvolf, l_aSTNvolf];

    % Left Save
    patTEMP2 = convertCharsToStrings(patTEMP);
    dataTab.PatID(mi) = patTEMP2;
    dataTab.l_wSTNVol(mi) = l_wSTNvolf;
    dataTab.l_mSTNVol(mi) = l_mSTNvolf;
    dataTab.l_lSTNVol(mi) = l_lSTNvolf;
    dataTab.a_lSTNVol(mi) = l_aSTNvolf;

    % Right %
    rVTA.vertices = tempFile.(tempFN{1}).right.VTA.vertices;
    rVTA.faces = tempFile.(tempFN{1}).right.VTA.faces;
    rwSTN.v = tempFile.(tempFN{1}).right.STN.wholeSTN.vertices;
    rwSTN.f = tempFile.(tempFN{1}).right.STN.wholeSTN.faces;
    rmSTN.v = tempFile.(tempFN{1}).right.STN.STN_motor_right.vertices;
    rmSTN.f = tempFile.(tempFN{1}).right.STN.STN_motor_right.faces;
    rlSTN.v = tempFile.(tempFN{1}).right.STN.STN_limbic_right.vertices;
    rlSTN.f = tempFile.(tempFN{1}).right.STN.STN_limbic_right.faces;
    raSTN.v = tempFile.(tempFN{1}).right.STN.STN_associative_right.vertices;
    raSTN.f = tempFile.(tempFN{1}).right.STN.STN_associative_right.faces;

    mesh_VTA_R = extendedObjectMesh(rVTA.vertices, rVTA.faces);
    mesh_wSTN_R = extendedObjectMesh(rwSTN.v, rwSTN.f);
    mesh_mSTN_R = extendedObjectMesh(rmSTN.v, rmSTN.f);
    mesh_lSTN_R = extendedObjectMesh(rlSTN.v, rlSTN.f);
    mesh_aSTN_R = extendedObjectMesh(raSTN.v, raSTN.f);

    % Right - Output volumes from overlay
    [r_wSTNvolf, r_mSTNvolf, r_lSTNvolf, r_aSTNvolf] = getVOLover(rVTA, mesh_wSTN_R , mesh_mSTN_R, mesh_lSTN_R, mesh_aSTN_R);
    fraC(:) = [r_lSTNvolf, r_mSTNvolf, l_wSTNvolf, r_aSTNvolf];

    % Right Save
    patTEMP2 = convertCharsToStrings(patTEMP);
    dataTab.PatID(mi) = patTEMP2;
    dataTab.r_wSTNVol(mi) = r_wSTNvolf;
    dataTab.r_mSTNVol(mi) = r_mSTNvolf;
    dataTab.r_lSTNVol(mi) = r_lSTNvolf;
    dataTab.r_aSTNVol(mi) = r_aSTNvolf;

    % % Cd back to main DIR
    % cd(mainDIR)

end %for

% Save all
saveLoc = 'Z:\Hirt_Neurosurgery_Projects\DBS_Dreem_AJB\CaseData\VTA_mesh';
cd(saveLoc)
writetable(dataTab, 'volOcc_STN.csv')

end %function



% getVOLover fxn
function [FwSTNVol, FmSTNVol, FlSTNVol, FfaSTNVol] = getVOLover(vtaI ,...
    wSTNMesh, mSTNMesh, lSTNMesh, aSTNMesh)

wSTNVol = abs(meshVolume(wSTNMesh.Vertices,wSTNMesh.Faces));
mSTNVol = abs(meshVolume(mSTNMesh.Vertices,mSTNMesh.Faces));
lSTNVol = abs(meshVolume(lSTNMesh.Vertices,lSTNMesh.Faces));
aSTNVol = abs(meshVolume(aSTNMesh.Vertices,aSTNMesh.Faces));

mesh_VTA.vertices = vtaI.vertices;
mesh_VTA.faces = vtaI.faces;

mesh_wSTN.vertices = wSTNMesh.Vertices;
mesh_wSTN.faces = wSTNMesh.Faces;

mesh_mSTN.vertices = mSTNMesh.Vertices;
mesh_mSTN.faces = mSTNMesh.Faces;

mesh_lSTN.vertices = lSTNMesh.Vertices;
mesh_lSTN.faces = lSTNMesh.Faces;

mesh_aSTN.vertices = aSTNMesh.Vertices;
mesh_aSTN.faces = aSTNMesh.Faces;


[meshCHECK_wSTN , mesh_wSTN_ovVTA] = extractVolIn(mesh_VTA , mesh_wSTN , 1);
[meshCHECK_mSTN , mesh_mSTN_ovVTA] = extractVolIn(mesh_VTA , mesh_mSTN , 1);
[meshCHECK_lSTN , mesh_lSTN_ovVTA] = extractVolIn(mesh_VTA , mesh_lSTN , 1);
[meshCHECK_aSTN , mesh_aSTN_ovVTA] = extractVolIn(mesh_VTA , mesh_aSTN , 1);

figure;
drawMesh(mesh_wSTN.vertices, mesh_wSTN.faces, 'FaceAlpha', 0.2, 'FaceColor', 'b')
hold on
drawMesh(vtaI.vertices, vtaI.faces, 'FaceAlpha', 0.5, 'FaceColor', 'r')
hold on 
drawMesh(mesh_wSTN_ovVTA.vertices,mesh_wSTN_ovVTA.faces, 'FaceAlpha', 1, 'FaceColor', 'g')

if meshCHECK_wSTN == 0
    wSTN_VTA_Vol = 0;
else
    wSTN_VTA_Vol = abs(meshVolume(mesh_wSTN_ovVTA.vertices,mesh_wSTN_ovVTA.faces));
end

if meshCHECK_mSTN == 0
    mSTN_VTA_Vol = 0;
else
    mSTN_VTA_Vol = abs(meshVolume(mesh_mSTN_ovVTA.vertices,mesh_mSTN_ovVTA.faces));
end

if meshCHECK_lSTN == 0
    lSTN_VTA_Vol = 0;
else
    lSTN_VTA_Vol = abs(meshVolume(mesh_lSTN_ovVTA.vertices,mesh_lSTN_ovVTA.faces));
end

if meshCHECK_aSTN == 0
    aSTN_VTA_Vol = 0;
else
    aSTN_VTA_Vol = abs(meshVolume(mesh_aSTN_ovVTA.vertices,mesh_aSTN_ovVTA.faces));
end

FwSTNVol = (wSTN_VTA_Vol/wSTNVol)*100;
FmSTNVol = (mSTN_VTA_Vol/mSTNVol)*100;
FlSTNVol = (lSTN_VTA_Vol/lSTNVol)*100;
FfaSTNVol = (aSTN_VTA_Vol/aSTNVol)*100;

end





% extractVolIn fxn

function [meshCHECK , mesh_VTA_INSIDE] = extractVolIn(mesh_VTA , brainArea_Mesh , polyUse)


% USED mesh_CA4 and mesh_VTA
switch polyUse
    case 1
        indicesIN = inpolyhedron(brainArea_Mesh, mesh_VTA.vertices,'flipnormals',true);
    case 2
        % faces, vertices, points of interest
        indicesIN = in_polyhedron(brainArea_Mesh.faces,brainArea_Mesh.vertices,mesh_VTA.vertices);
end

if sum(indicesIN) == 0
    mesh_VTA_INSIDE = 0;
    meshCHECK = 0;
    return
end

meshCHECK = 1;

mesh_VTA_INSIDE.vertices = mesh_VTA.vertices(indicesIN,:);
mesh_VTAremInds = find(~indicesIN);

faceRow2rem = zeros(height(mesh_VTA.faces),1,'logical');
for mf = 1:height(mesh_VTA.faces)
    tmpRow = mesh_VTA.faces(mf,:);
    rowCheck = ismember(tmpRow,mesh_VTAremInds);
    if any(rowCheck)
        faceRow2rem(mf) = true;
    end
end

mesh_VTA_INSIDE.faces = mesh_VTA.faces(~faceRow2rem,:);

newVALS = 1:length(mesh_VTA_INSIDE.vertices);
meshVTAtfac = mesh_VTA_INSIDE.faces*1000;
uniVALS = unique(meshVTAtfac);

for ui = 1:length(uniVALS)

    meshVTAtfac(meshVTAtfac == uniVALS(ui)) = newVALS(ui);

end

mesh_VTA_INSIDE.faces = meshVTAtfac;

end
