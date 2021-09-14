<?php
/*SERVER CODE*/
session_start();
if (!isset($_SESSION['user']) || empty($_SESSION['user'])) {
    header("location:nopermission.php");
}
require_once '../function.php';
$db = new DataSourceResult();
if (isset($_POST) && !empty($_POST)):
/*BEGIN*/
    switch ($_POST['mode']):
    // case 'selectAllUser':
    //     try {
    //             $value['us.userID'] = null;
    //             $value['us.userTypeID'] = null;
    //             $value['ut.userType'] = null;
    //             $value['us.userCode'] = null;
    //             $value['us.classGroup'] = null;
    //             $value['us.fullName'] = null;
    //             $value['us.email'] = null;
    //             $value['us.mbti'] = null;
    //             $value['us.status'] = null;
    //             buildstring($_POST, $value);
    //             $request = json_decode(json_encode($_POST), false);
    //             $data = $db->read('user us left outer join user_type ut on ut.userTypeID=us.userTypeID', array_keys($value), $request);
    //             echo json_encode($data);
    //     } catch (Exception $e) {
    //         print_r($e->getMessage());
    //     }
    //     break;
    case 'selectAllRegistrationInformation':
        try {
                $value['ri.regisID'] = null;
                $value['ri.courseID'] = null;
                $value['ci.courseCode'] = null;
                $value['ci.courseName'] = null;
                $value['ri.userID'] = null;
                $value['us.fullName'] = null;
                $value['ri.classGroup'] = null;
                $value['ri.year'] = null;
                $value['ri.semester'] = null;
                $value['ri.status'] = null;
                buildstring($_POST, $value);
                $request = json_decode(json_encode($_POST), false);
                $data = $db->read('registration_information ri left outer join course_information ci on ri.courseID=ci.courseID left outer join user us on ri.userID=us.userID', array_keys($value), $request);
                echo json_encode($data);
        } catch (Exception $e) {
            print_r($e->getMessage());
        }
        break;
    // case 'selectAllClassGroup':
    //     try {
    //         $sql = "select distinct(classGroup) from registration_information";
    //         $data = $db->select($sql);
    //         echo json_encode($data);
    //     } catch (Exception $e) {
    //         print_r($e->getMessage());
    //     }
    //     break;
    case 'selectAllGroupType':
        try {
            $value['groupTypeID'] = null;
            $value['groupType'] = null;
            $value['status'] = null;
            $request = json_decode(json_encode($_POST), false);
            $data = $db->read('group_type', array_keys($value), $request);
            echo json_encode($data);
        } catch (Exception $e) {
            print_r($e->getMessage());
        }
        break;
    case 'selectAllAssignment':
        try {
            $value['ass.assignID'] = null;
            $value['ass.regisID'] = null;
            $value['ass.groupTypeID'] = null;
            $value['ass.assignTitle'] = null;
            $value['ass.assignDescription'] = null;
            $value['ass.assignDate'] = null;
            $value['ass.deadline'] = null;
            $value['ass.numGroup'] = null;
            $value['ass.status'] = null;
            $value['ci.courseCode'] = null;
            $value['ci.courseName'] = null;
            $value['us.fullName'] = null;
            $value['ri.classGroup'] = null;
            $value['ri.year'] = null;
            $value['ri.semester'] = null;
            $value['gt.groupType'] = null;
            buildstring($_POST, $value);
            $request = json_decode(json_encode($_POST), false);
            $data = $db->read('assignment ass 
            LEFT OUTER JOIN group_type gt ON ass.groupTypeID=gt.groupTypeID
            LEFT OUTER JOIN registration_information ri ON ass.regisID=ri.regisID
            LEFT OUTER JOIN course_information ci ON ri.courseID=ci.courseID
            LEFT OUTER JOIN user us ON ri.userID=us.userID', array_keys($value), $request);
            echo json_encode($data);
        } catch (Exception $e) {
            print_r($e->getMessage());
        }
        break;
    case 'insert':
        try {
            $value['assignID'] = null;
            $value['regisID'] = $_POST['regisID'];
            $value['groupTypeID'] = $_POST['groupTypeID'];
            $value['assignTitle'] = $_POST['assignTitle'];
            $value['assignDescription'] = $_POST['assignDescription'];
            $value['assignDate'] = $_POST['assignDate'];
            $value['deadline'] = $_POST['deadline'];
            $value['numGroup'] = $_POST['numGroup'];
            $value['status'] = isset($_POST['status']) ? 1 : 0;
            $request = json_decode(json_encode($value), false);
            $result = $db->create('assignment', array_keys($value), $request, 'assignID');

            //check MBTI assignment
            if($_POST['groupTypeID']==3){
                //collect all student that assign to classgroup
                $sql="select * from user where classGroup='".$_POST['classGroup']."'";
                $student=$db->select($sql);
                $groupNum=$_POST['numGroup'];
                $groupArray=array();
                $type1=array('ENTJ','ENTP','INTJ','INTP');
                $type2=array('ENFJ','ENFP','INFJ','INFP');
                $type3=array('ESTJ','ESFJ','ISTJ','ISFJ');
                $type4=array('ESTP','ESFP','ISTP','ISFP');

                foreach($student['data'] as $i=>$v){
                    if(array_search($v['mbti'], $type1)!==false){
                        $mbtiTable[]=array("type"=>1,"userID"=>$v['userID'],"mbti"=>$v['mbti']);
                    }else if(array_search($v['mbti'], $type2)!==false){
                        $mbtiTable[]=array("type"=>2,"userID"=>$v['userID'],"mbti"=>$v['mbti']);
                    }else if(array_search($v['mbti'], $type3)!==false){
                        $mbtiTable[]=array("type"=>3,"userID"=>$v['userID'],"mbti"=>$v['mbti']);
                    }else if(array_search($v['mbti'], $type4)!==false){
                        $mbtiTable[]=array("type"=>4,"userID"=>$v['userID'],"mbti"=>$v['mbti']);
                    }else{
                        $mbtiTable[]=array("type"=>5,"userID"=>$v['userID'],"mbti"=>$v['mbti']);
                    }
                }
                usort($mbtiTable, function($a, $b) {
                    return $a['type'] <=> $b['type'];
                });
                $count=1;
                foreach($mbtiTable as $i=>$v){
                    $groupArray[$count][]=$mbtiTable[$i];
                    if($count%$groupNum==0)$count=0;
                    $count++;
                }
                $value=array();
                foreach($groupArray as $i=>$v){
                    foreach($v as $ii=>$vv){
                        $value['assignID'] = $result['data'][0]->assignID;
                        $value['groupNum'] = $i;
                        $value['userID'] = $vv['userID'];                       
                        $request = json_decode(json_encode($value), false);
                        $db->create('group_information', array_keys($value), $request, 'groupInfoID');
                    }
                }
                
            }//---

            if (isset($result['errors'])) {
                throw new Exception($result['errors'][0]);
            } else {
                echo 1;
            }
        } catch (Exception $e) {
            print_r($e->getMessage());
        }
        break;
    case 'update':
        try {
            $value['assignID'] = $_POST['assignID'];
            $value['regisID'] = $_POST['regisID'];
            $value['groupTypeID'] = $_POST['groupTypeID'];
            $value['assignTitle'] = $_POST['assignTitle'];
            $value['assignDescription'] = $_POST['assignDescription'];
            $value['assignDate'] = $_POST['assignDate'];
            $value['deadline'] = $_POST['deadline'];
            $value['numGroup'] = $_POST['numGroup'];
            $value['status'] = isset($_POST['status']) ? 1 : 0;
            $request = json_decode(json_encode($value), false);
            $result = $db->update('assignment', array_keys($value), $request, 'assignID');

            //check MBTI assignment
            if($_POST['groupTypeID']==3){
                //delete all group information
                $sql="delete from group_information where assignID='".$_POST['assignID']."'";
                $db->execute($sql);
                $sql="delete from discussion where assignID='".$_POST['assignID']."'";
                $db->execute($sql);
                $sql="delete from evaluation_answer where assignID='".$_POST['assignID']."'";
                $db->execute($sql);

                //collect all student that assign to classgroup
                $sql="select * from user where classGroup='".$_POST['classGroup']."'";
                $student=$db->select($sql);
                $groupNum=$_POST['numGroup'];
                $groupArray=array();
                $type1=array('ENTJ','ENTP','INTJ','INTP');
                $type2=array('ENFJ','ENFP','INFJ','INFP');
                $type3=array('ESTJ','ESFJ','ISTJ','ISFJ');
                $type4=array('ESTP','ESFP','ISTP','ISFP');

                foreach($student['data'] as $i=>$v){
                    if(array_search($v['mbti'], $type1)!==false){
                        $mbtiTable[]=array("type"=>1,"userID"=>$v['userID'],"mbti"=>$v['mbti']);
                    }else if(array_search($v['mbti'], $type2)!==false){
                        $mbtiTable[]=array("type"=>2,"userID"=>$v['userID'],"mbti"=>$v['mbti']);
                    }else if(array_search($v['mbti'], $type3)!==false){
                        $mbtiTable[]=array("type"=>3,"userID"=>$v['userID'],"mbti"=>$v['mbti']);
                    }else if(array_search($v['mbti'], $type4)!==false){
                        $mbtiTable[]=array("type"=>4,"userID"=>$v['userID'],"mbti"=>$v['mbti']);
                    }else{
                        $mbtiTable[]=array("type"=>5,"userID"=>$v['userID'],"mbti"=>$v['mbti']);
                    }
                }
                usort($mbtiTable, function($a, $b) {
                    return $a['type'] <=> $b['type'];
                });
                $count=1;
                foreach($mbtiTable as $i=>$v){
                    $groupArray[$count][]=$mbtiTable[$i];
                    if($count%$groupNum==0)$count=0;
                    $count++;
                }
                $value=array();
                foreach($groupArray as $i=>$v){
                    foreach($v as $ii=>$vv){
                        $value['assignID'] = $_POST['assignID'];
                        $value['groupNum'] = $i;
                        $value['userID'] = $vv['userID'];                       
                        $request = json_decode(json_encode($value), false);
                        $db->create('group_information', array_keys($value), $request, 'groupInfoID');
                    }
                }
                
            }//---

            if (isset($result['errors'])) {
                throw new Exception($result['errors'][0]);
            } else {
                echo 1;
            }
        } catch (Exception $e) {
            print_r($e->getMessage());
        }
        break;
    case 'delete':
        try {
            //delete all group information
            $sql="delete from group_information where assignID='".$_POST['assignID']."'";
            $db->execute($sql);
            $sql="delete from discussion where assignID='".$_POST['assignID']."'";
            $db->execute($sql);
            $sql="delete from evaluation_answer where assignID='".$_POST['assignID']."'";
            $db->execute($sql);

            $value['assignID'] = $_POST["assignID"];
            $request = json_decode(json_encode($value), false);
            $result = $db->destroy('assignment', $request, 'assignID');
            if (isset($result['errors'])) {
                throw new Exception($result['errors'][0]);
            } else {
                echo 1;
            }
        } catch (Exception $e) {
            print_r($e->getMessage());
        }
        break;
        endswitch;
/*END BEGIN*/
        unset($db);
        exit();
    endif;
/*END SERVER CODE*/
    ?>
<!doctype html>
<html lang="<?=$_SESSION['setting']['lang']?>">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Developer Mr.Vilerswat Noosaeng srel90@gmail.com 0840900050">
    <meta name="author" content="Vilerswat Noosaeng">
    <title>Student Grouping System | Sign in</title>
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="../kendoui/styles/kendo.common-material.min.css" />
    <link rel="stylesheet" href="../kendoui/styles/kendo.material.min.css" />
    <link rel="stylesheet" href="../kendoui/styles/kendo.material.mobile.min.css" />

    <link href="style.css" rel="stylesheet">
    <style>
        .dropdown-header {
                    border-width: 0 0 1px 0;
                }

                .k-list-container > .k-footer {
                    padding: 10px;
                }
                #regisID .k-item {
                    line-height: 1em;
                    min-width: 300px;
                }
                .k-material #regisID .k-item,
                .k-material #regisID .k-item.k-state-hover,
                .k-materialblack #regisID .k-item,
                .k-materialblack #regisID .k-item.k-state-hover {
                    padding-left: 5px;
                    border-left: 0;
                }

                #regisID .k-item > span {
                    -webkit-box-sizing: border-box;
                    -moz-box-sizing: border-box;
                    box-sizing: border-box;
                    display: inline-block;
                    vertical-align: top;
                    margin: 20px 10px 10px 5px;
                }

                #regisID .k-item > span:first-child {
                    -moz-box-shadow: inset 0 0 30px rgba(0,0,0,.3);
                    -webkit-box-shadow: inset 0 0 30px rgba(0,0,0,.3);
                    box-shadow: inset 0 0 30px rgba(0,0,0,.3);
                    margin: 10px;
                    width: 50px;
                    height: 50px;
                    border-radius: 50%;
                    background-size: 100%;
                    background-repeat: no-repeat;
                }

                #regisID h3 {
                    font-size: 1.2em;
                    font-weight: normal;
                    margin: 0 0 1px 0;
                    padding: 0;
                }

                #regisID p {
                    margin: 0;
                    padding: 0;
                    font-size: .8em;
                }
    </style>
</head>

<body>
    <?php require_once 'header.php';?>
    <div class="container-fluid">
        <div class="row">
            <?php require_once 'nav.php';?>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div
                    class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2"><?=$_SESSION['setting']['lang'] == 'en' ? 'Assignment' : 'ข้อมูลการมอบหมายงาน';?></h1>
                </div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a
                                href="main.php"><?=$_SESSION['setting']['lang'] == 'en' ? 'Dashboard' : 'แผงควบคุม';?></a></li>
                        <li class="breadcrumb-item">
                            <?=$_SESSION['setting']['lang'] == 'en' ? 'Assignment' : 'ข้อมูลการมอบหมายงาน';?>
                        </li>
                    </ol>
                </nav>
                <div id="data-grid"></div>
                <div class="card mt-4">
                    <div class="card-body">
                        <form class="row g-3" id="scriptForm">
                            <div class="col-md-3">
                                <label for="regisID"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Course' : 'วิชา';?>*</label>
                                <div class="col">
                                    <input type="text" id="regisID" name="regisID" style="width:100%">
                                </div>
                            </div>
                            <div class="col-md-3"><label for="fullName"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Instructor' : 'ผู้สอน';?></label>
                                <div class="input-group">
                                    <input type="text" class="k-textbox" id="fullName" name="fullName"
                                        readonly style="width:100%">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <label for="classGroup"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Section' : 'กลุ่มเรียน';?></label>
                                <div class="col">
                                    <input type="text" class="k-textbox" id="classGroup" name="classGroup"
                                    readonly style="width:100%">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <label for="year"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Year' : 'ปีการศึกษา';?></label>
                                <div class="col"><input type="text" class="k-textbox" id="year" name="year" readonly style="width:100%"> </div>
                            </div>
                            <div class="col-md-2">
                                <label for="semester"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Semester' : 'ภาคการศึกษา';?></label>
                                <div class="col"><input type="text" class="k-textbox" id="semester" name="semester" readonly style="width:100%">
                                </div>
                            </div>
                            
                            <div class="col-md-3">
                                <label for="groupTypeID"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Group type' : 'ประเภทการจับกลุ่ม';?>*</label>
                                <div class="col">
                                    <input type="text" id="groupTypeID" name="groupTypeID" style="width:100%" required
                                        validationMessage="<?=$_SESSION['setting']['lang'] == 'en' ? 'Please select group type.' : 'กรุณาเลือกประเภทการจับกลุ่ม';?>">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label for="numGroup"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Number of group' : 'จำนวนกลุ่ม';?></label>
                                <div class="col"><input type="text" id="numGroup" name="numGroup" style="width:100%">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label for="assignDate"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Assignment date' : 'วันที่มอบหมาย';?></label>
                                <div class="col"><input type="text" id="assignDate" name="assignDate" style="width:100%"> </div>
                            </div>
                            <div class="col-md-3">
                                <label for="deadline"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Deadline' : 'กำหนดส่ง';?></label>
                                <div class="col"><input type="text" id="deadline" name="deadline" style="width:100%"> </div>
                            </div>
                            <div class="col-md-3">
                                <label for="assignTitle"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Assignment Title' : 'หัวข้อการมอบหมายงาน';?></label>
                                <div class="col">
                                    <input type="text" class="k-textbox" id="assignTitle" name="assignTitle"
                                        style="width:100%">
                                </div>
                            </div>
                            <div class="col-md-9">
                                <label for="assignDescription"
                                    class="form-label"><?=$_SESSION['setting']['lang'] == 'en' ? 'Description' : 'รายละเอียดการมอบหมายงาน';?></label>
                                <div class="col">
                                    <textarea  id="assignDescription" name="assignDescription"
                                        style="width:100%"></textarea>

                                </div>
                            </div>
                            <div class="col-12">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="status" name="status" value="1"
                                        checked="checked">
                                    <label class="form-check-label" for="status">
                                        <?=$_SESSION['setting']['lang'] == 'en' ? 'Active' : 'ใช้งาน';?>
                                    </label>
                                </div>
                            </div>
                            
                            <div class="col-12">
                                <button type="submit" class="k-button k-primary"><span
                                        class="material-icons">save</span><?=$_SESSION['setting']['lang'] == 'en' ? 'Save' : 'บันทึก';?></button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <!-- <div id="windowUserID">
        <div id="data-grid-user"></div>
    </div> -->
    <div class="loader-wrapper" style="display:none">
        <div class="loader"></div>
    </div>
    <script src="../kendoui/js/jquery.min.js"></script>
    <script src="../jquery.form.min.js"></script>
    <script src="../kendoui/js/kendo.all.min.js"></script>
    <script src="../bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="function.js"></script>
    <script type="text/x-kendo-template" id="toolbar">
        <div class="form-row">
            <button type="button" class="k-button k-primary" id="btn-add"><span class="material-icons">add</span><?php echo $_SESSION['setting']['lang'] == 'en' ? "Add" : "เพิ่ม" ?></button>
            <button type="button" class="k-button k-primary" id="btn-edit"><span class="material-icons">edit</span><?php echo $_SESSION['setting']['lang'] == 'en' ? "Edit" : "แก้ไข" ?></button>
            <button type="button" class="k-button k-primary" id="btn-delete"><span class="material-icons">delete</span><?php echo $_SESSION['setting']['lang'] == 'en' ? "Del" : "ลบ" ?></button>
            <button type="button" class="k-button k-primary" id="btn-cancel"><span class="material-icons">cancel</span><?php echo $_SESSION['setting']['lang'] == 'en' ? "Cancel" : "ยกเลิก" ?></button>
            <input type="text" id="search" class="k-textbox">
            <button type="button" class="k-button k-primary" id="btn-search"><span class="material-icons">search</span><?php echo $_SESSION['setting']['lang'] == 'en' ? "Search" : "ค้นหา" ?></button>
        </div>
    </script>
    <script type="text/x-kendo-template" id="usertoolbar">
        <div class="form-row">
            <input type="text" id="txt-search-user" class="k-textbox">
            <button type="button" class="k-button k-primary k-primary k-primary" id="btn-search-user"><span class="material-icons">search</span><?php echo $_SESSION['setting']['lang'] == 'en' ? "Search" : "ค้นหา" ?></button>
            <button type="button" class="k-button k-primary k-primary k-primary" id="btn-select-user"><span class="material-icons">done</span><?php echo $_SESSION['setting']['lang'] == 'en' ? "Select" : "เลือก" ?></button>
        </div>
    </script>
    <script>
    var page = new page();
    $(function() {
        page.initial();
        page.eventhandle();
        page.validation();
    });

    function page() {
        this.validator;
        this.options;
        this.mode = "insert";
        this.assignID = "";
        page.prototype.initial = function() {
            $('#data-grid').kendoGrid({
                dataSource: {
                    transport: {
                        read: {
                            dataType: 'json',
                            type: 'POST',
                            data: ({
                                mode: 'selectAllAssignment'
                            }),
                            url: '<?=$_SERVER['PHP_SELF']?>'
                        }
                    },
                    dataType: 'json',
                    autoSync: false,
                    pageSize: 5,
                    schema: {
                        data: 'data',
                        total: 'total'
                    },
                    serverPaging: true,
                    serverFiltering: true,
                    serverSorting: true,
                    sort: { field: "ass.assignID", dir: "desc" }
                },
                groupable: true,
                resizable: true,
                filterable: true,
                reorderable: true,
                sortable: true,
                columnMenu: true,
                selectable: 'row',
                pageable: {
                    pageSizes: true,
                    refresh: true,
                    buttonCount: 5
                },
                columns: [{
                        field: 'assignID',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "ID" : "ลำดับ"?>',
                        id: "ass.assignID"
                    },
                    {
                        field: 'courseCode',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Course code" : "รหัสวิชา"?>',
                        id: "ci.courseCode"
                    },
                    {
                        field: 'courseName',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Course name" : "ชื่อวิชา"?>',
                        id: "ci.courseName"
                    },
                    {
                        field: 'assignTitle',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Assignment Title" : "หัวข้อการมอบหมายงาน"?>',
                        id: "ass.assignTitle"
                    },
                    {
                        field: 'assignDescription',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Description" : "รายละเอียดการมอบหมายงาน"?>',
                        id: "ass.assignDescription"
                    },
                    {
                        field: 'fullName',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Instructor" : "ผู้สอน"?>',
                        id: "us.fullName"
                    },
                    {
                        field: 'year',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Year" : "ปีการศึกษา"?>',
                        id: "ri.year"
                    },
                    {
                        field: 'semester',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Semester" : "ภาคการศึกษา"?>',
                        id: "ri.semester"
                    },
                    {
                        field: 'classGroup',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Section" : "กลุ่มเรียน"?>',
                        id: "ri.classGroup"
                    },
                    {
                        field: 'groupType',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Group type" : "ประเภทการจับกลุ่ม"?>',
                        id: "gt.groupType"
                    },
                    {
                        field: 'numGroup',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Number of group" : "จำนวนกลุ่ม"?>',
                        id: "ass.numGroup"
                    },
                    {
                        field: 'assignDate',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Assignment date" : "วันที่มอบหมาย"?>',
                        id: "ass.assignDate"
                    },
                    {
                        field: 'deadline',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Deadline" : "กำหนดส่ง"?>',
                        id: "ass.deadline"
                    },
                    {
                        field: 'status',
                        title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Status" : "สถานะ"?>',
                        template: '#=status==1?"Active":"Inactive"#',
                        id: "ass.status"
                    },
                ],
                dataBound: function() {
                    var grid = this;
                    for (var i = 0; i < grid.columns.length; i++) {
                            grid.autoFitColumn(i);
                    }
                },
                change: function(e) {
                    var selectedItem = this.dataItem(this.select());
                    if (selectedItem) {
                        page.bindData(selectedItem);
                    }
                },
                toolbar: kendo.template($("#toolbar").html())
            });
            $("#regisID").kendoDropDownList({
                optionLabel: "<?=$_SESSION['setting']['lang'] == 'en' ? "Select Course..." : "เลือกวิชา"?>",
                dataTextField: "courseName",
                dataValueField: "regisID",
                headerTemplate: '<div class="dropdown-header k-widget k-header">' +
                                    '<div><?=$_SESSION['setting']['lang'] == 'en' ? "Course code Course name" : "รหัสวิชา ชื่อวิชา"?> </div>' +
                                    '<div>[<?=$_SESSION['setting']['lang'] == 'en' ? "Instructor,Section,year,semester" : "ผู้สอน,กลุ่มเรียน,ปีการศึกษา,ภาคการศึกษา"?>]</div>' +
                                '</div>',
                valueTemplate: '<span>#: data.courseCode #</span> <span>#: data.courseName #</span>',
                template: '<div class="k-state-default">#: data.courseCode # #: data.courseName #</div><div>[#: data.fullName #,#: data.classGroup #,#: data.year #,#: data.semester #]</div>',
                filter: "contains",
                height: 500,
                dataSource: {
                    transport: {
                        read: {
                            dataType: "json",
                            type: "POST",
                            data: ({
                                mode: 'selectAllRegistrationInformation'
                            }),
                            url: '<?=$_SERVER['PHP_SELF']?>'
                        }
                    },
                    schema: {
                        data: "data",
                        total: "total"
                    },
                    serverFiltering: true,
                    filter: [{
                        field: "ri.status",
                        operator: "eq",
                        value: '1'
                    }]

                },
                select:function(e){
                    $('#fullName').val(e.dataItem.fullName);
                    $('#classGroup').val(e.dataItem.classGroup);
                    $('#year').val(e.dataItem.year);
                    $('#semester').val(e.dataItem.semester);
                }
            });
            // $("#classGroup").kendoAutoComplete({
            //     dataTextField: "classGroup",
            //     dataSource: {
            //         transport: {
            //             read: {
            //                 dataType: "json",
            //                 type: "POST",
            //                 data: ({
            //                     mode: 'selectAllClassGroup'
            //                 }),
            //                 url: '<?=htmlspecialchars($_SERVER['PHP_SELF']);?>'
            //             }
            //         },
            //         schema: {
            //             data: "data",
            //             total: "total"
            //         }
            //     },
            //     filter: "startswith",
            //     placeholder: "<?=$_SESSION['setting']['lang'] == 'en' ? "Enter Section" : "พิมพ์กลุ่มเรียน"?>",

            // });
            // $('#data-grid-user').kendoGrid({
            //     autoBind: false,
            //     dataSource: {
            //         transport: {
            //             read: {
            //                 dataType: 'json',
            //                 type: 'POST',
            //                 data: ({
            //                     mode: 'selectAllUser'
            //                 }),
            //                 url: '<?=$_SERVER['PHP_SELF']?>'
            //             }
            //         },
            //         dataType: 'json',
            //         autoSync: false,
            //         pageSize: 5,
            //         schema: {
            //             data: 'data',
            //             total: 'total'
            //         },
            //         serverPaging: true,
            //         serverFiltering: true,
            //         serverSorting: true,
            //         filter: [{
            //             field: "us.userTypeID",
            //             operator: "eq",
            //             value: '2'
            //         }]
            //     },
            //     // groupable: true,
            //     resizable: true,
            //     filterable: true,
            //     reorderable: true,
            //     sortable: true,
            //     columnMenu: true,
            //     selectable: 'row',
            //     pageable: {
            //         pageSizes: true,
            //         refresh: true,
            //         buttonCount: 5
            //     },
            //     columns: [{
            //             field: 'userID',
            //             title: '<?=$_SESSION['setting']['lang'] == 'en' ? "User ID" : "รหัสลำดับข้อมูลผู้ใช้"?>',
            //             id: "us.userID"
            //         },
            //         // {
            //         //     field: "userTypeID",
            //         //     hidden: true,
            //         //     id: "ut.userTypeID"
            //         // },
            //         {
            //             field: 'userType',
            //             title: '<?=$_SESSION['setting']['lang'] == 'en' ? "User type" : "ประเภทผู้ใช้"?>',
            //             id: "ut.userType"
            //         },
            //         {
            //             field: 'userCode',
            //             title: '<?=$_SESSION['setting']['lang'] == 'en' ? "User Code" : "รหัสนักศึกษา/รหัสอาจารย์"?>',
            //             id: "us.userCode"
            //         },
            //         {
            //             field: 'classGroup',
            //             title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Section" : "กลุ่มเรียน"?>',
            //             id: "us.classGroup"
            //         },
            //         {
            //             field: 'fullName',
            //             title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Fullname" : "ชื่อ สกุล"?>',
            //             id: "us.fullName"
            //         },
            //         {
            //             field: 'email',
            //             title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Email" : "อีเมล"?>',
            //             id: "us.email"
            //         },
            //         {
            //             field: 'mbti',
            //             title: '<?=$_SESSION['setting']['lang'] == 'en' ? "mbti" : "รูปแบบบุคคลิกภาพ"?>',
            //             id: "us.mbti"
            //         },
            //         {
            //             field: 'status',
            //             title: '<?=$_SESSION['setting']['lang'] == 'en' ? "Status" : "สถานะ"?>',
            //             template: '#=status==1?"<?=$_SESSION['setting']['lang'] == 'en' ? "Active" : "เปิดใช้งาน"?>":"<?=$_SESSION['setting']['lang'] == 'en' ? "Inactive" : "ระงับการใช้"?>"#',
            //             id: "us.status"
            //         },
            //     ],
            //     dataBound: function() {
            //         var grid = this;
            //         for (var i = 0; i < grid.columns.length; i++) {
            //             grid.autoFitColumn(i);
            //         }
            //     },
            //     // change: function(e) {
            //     //     var selectedItem = this.dataItem(this.select());
            //     //     if (selectedItem) {
            //     //         page.userID=selectedItem.userID;
            //     //         $('#fullName').val(selectedItem.fullName);
            //     //         $('#windowUserID').data("kendoWindow").close();
            //     //     }
            //     // },
            //     toolbar: kendo.template($("#usertoolbar").html())
            // });
            // $("#windowUserID").kendoWindow({
            //     actions: ["Minimize", "Maximize", "Close"],
            //     width: "75%",
            //     title: "<?=$_SESSION['setting']['lang'] == 'en' ? 'Select instructor' : 'ค้นหาผู้สอน';?>",
            //     visible: false,
            //     open: function() {
            //         $('#data-grid-user').data('kendoGrid').dataSource.read();
            //     }
            // });
            // $("#year").kendoDatePicker({
            //     start: "decade",
            //     depth: "decade",
            //     format: "yyyy",
            //     dateInput: true
            // });
            // $("#semester").kendoNumericTextBox({
            //     min: 1,
            //     format: '0'
            // });
            $("#assignDescription").kendoTextArea({
                rows: 4,
            });
            $("#numGroup").kendoNumericTextBox({
                value:1,
                min: 1,
                format: '0'
            });
            $("#assignDate").kendoDateTimePicker({
                value: new Date(),
                format: "yyyy-MM-dd hh:mm tt",
                dateInput: true,
                change:function(){
                    $("#deadline").data('kendoDateTimePicker').min(this.value());
                    $("#deadline").data('kendoDateTimePicker').value(this.value());
                }
            });
            $("#deadline").kendoDateTimePicker({
                value: new Date(),
                format: "yyyy-MM-dd hh:mm tt",
                dateInput: true
            });
            $("#groupTypeID").kendoDropDownList({
                optionLabel: "<?=$_SESSION['setting']['lang'] == 'en' ? "Select group type..." : "เลือกประเภทการจับกลุ่ม" ?>",
                dataTextField: "groupType",
                dataValueField: "groupTypeID",
                dataSource: {
                    transport: {
                        read: {
                            dataType: "json",
                            type: "POST",
                            data: ({
                                mode: 'selectAllGroupType'
                            }),
                            url: '<?=$_SERVER['PHP_SELF']?>'
                        }
                    },
                    schema: {
                        data: "data",
                        total: "total"
                    },
                    serverFiltering: true,
                    filter: [{
                        field: "status",
                        operator: "eq",
                        value: '1'
                    }]
                }
            });
        }
        page.prototype.bindData = function(selectedItem) {
            page.mode = "update";
            page.assignID = selectedItem.assignID;
            //$('#regisID').data('kendoDropDownList').value(selectedItem.regisID);
            $('#regisID').data('kendoDropDownList').select(function(dataItem) {
                return dataItem.regisID === selectedItem.regisID;
            });
            $('#fullName').val(selectedItem.fullName);
            $('#classGroup').val(selectedItem.classGroup);
            $('#year').val(selectedItem.year);
            $('#semester').val(selectedItem.semester);
            //$('#groupTypeID').data('kendoDropDownList').value(selectedItem.groupTypeID);
            $('#groupTypeID').data('kendoDropDownList').select(function(dataItem) {
                return dataItem.groupTypeID === selectedItem.groupTypeID;
            });
            $('#numGroup').data('kendoNumericTextBox').value(selectedItem.numGroup);
            $('#assignDate').data('kendoDateTimePicker').value(selectedItem.assignDate);
            $('#deadline').data('kendoDateTimePicker').value(selectedItem.deadline);
            $('#assignTitle').val(selectedItem.assignTitle);
            $('#assignDescription').data('kendoTextArea').value(selectedItem.assignDescription);
            setCHKValue('status', selectedItem.status);
        }
        page.prototype.eventhandle = function() {
            // $('#btn-select-user').click(function() {
            //     var list = $('#data-grid-user').data('kendoGrid');
            //     var selectedItem = list.dataItem(list.select());
            //     if (selectedItem == null) {
            //         kendo.alert(
            //             '<?php echo $_SESSION['setting']['lang'] == 'en' ? "Please select the record you want to select." : "กรุณาเลือกรายการที่ต้องการ" ?>'
            //         );
            //         return;
            //     }
            //     page.userID = selectedItem.userID;
            //     $('#fullName').val(selectedItem.fullName);
            //     $('#windowUserID').data("kendoWindow").close();
            // });
            // $('#btn-window').click(function() {
            //     $('#windowUserID').data("kendoWindow").center().open();
            // });
            // $("#data-grid-user").on("dblclick", "tr.k-state-selected", function() {
            //     var list = $('#data-grid-user').data('kendoGrid');
            //     var selectedItem = list.dataItem(list.select());
            //     page.userID = selectedItem.userID;
            //     $('#fullName').val(selectedItem.fullName);
            //     $('#windowUserID').data("kendoWindow").close();
            // });
            $('#btn-add').click(function() {
                if ($('#btn-add').prop('disabled')) return;
                $("#btn-add,#btn-edit,#btn-delete").prop('disabled', 'disabled');
                page.clearform();
                $('#groupType').focus();
            });
            $('#btn-edit').click(function() {
                if ($('#btn-edit').prop('disabled')) return;
                var list = $('#data-grid').data('kendoGrid');
                var selectedItem = list.dataItem(list.select());
                if (selectedItem == null) {
                    kendo.alert(
                        '<?php echo $_SESSION['setting']['lang'] == 'en' ? "Please select the record you want to edit." : "กรุณาเลือกรายการที่ต้องการแก้ไข" ?>'
                    );
                    return;
                }
                $("#btn-add,#btn-edit,#btn-delete").prop('disabled', 'disabled');
                page.bindData(selectedItem);
            });
            $("#btn-delete").click(function() {
                if ($("#btn-delete").prop("disabled")) return;
                var list = $('#data-grid').data('kendoGrid');
                var selectedItem = list.dataItem(list.select());
                if (selectedItem == null) {
                    kendo.alert(
                        '<?php echo $_SESSION['setting']['lang'] == 'en' ? "Please select the record you want to delete." : "กรุณาเลือกรายการที่ต้องการลบ" ?>'
                    );
                    return;
                }
                kendo.confirm("<?php echo $_SESSION['setting']['lang'] == 'en' ? "Are you sure?" : "ยืนยันการลบ" ?>")
                    .then(function() {
                        ajax("<?=$_SERVER['PHP_SELF']?>", "POST", "json", ({
                            mode: 'delete',
                            assignID: selectedItem.assignID
                        }), true, true, function(response) {
                            if (response == true) {
                                kendo.alert(
                                    '<?php echo $_SESSION['setting']['lang'] == 'en' ? "Successful operation." : "การดำเนินการเสร็จสมบูรณ์" ?>'
                                );
                            } else {
                                kendo.alert(response);
                            }
                            page.clearform();
                        });
                    });

            });
            $("#btn-cancel").click(function() {
                $("#btn-add,#btn-edit,#btn-delete").prop('disabled', '');
                page.clearform();
            });
            $("#scriptForm").submit(function(e) {
                e.preventDefault();
                $("#btn-add,#btn-edit,#btn-delete").prop('disabled', '');
                var options = {
                    success: function(response) {
                        $('.loader-wrapper').hide();
                        if ($.trim(response) == true) {
                            kendo.alert(
                                '<?php echo $_SESSION['setting']['lang'] == 'en' ? "Successful operation." : "การดำเนินการเสร็จสมบูรณ์" ?>'
                            );
                            page.reloaddata();
                        } else {
                            kendo.alert(response);
                        }
                    },
                    type: 'POST',
                    data: {
                        mode: page.mode,
                        assignID: page.assignID
                    },
                    resetForm: true
                };
                if (page.validator.validate()) {
                    $('.loader-wrapper').show();
                    $("#scriptForm").ajaxSubmit(options);
                }

            });
            $('#btn-search').click(function() {
                var searchstring = $('#search').val().toUpperCase();
                var kgrid = $('#data-grid').data('kendoGrid');
                var searchword = searchstring.split(" ");
                if (searchstring) {
                    var orfilter = {
                        logic: 'or',
                        filters: []
                    };
                    var andfilter = {
                        logic: 'and',
                        filters: []
                    };
                    $.each(searchword, function(i, v) {
                        if (v.trim() != '') {
                            $.each(searchword, function(i, v1) {
                                if (v1.trim() != '') {
                                    $.each(kgrid.columns, function(key, column) {
                                        orfilter.filters.push({
                                            field: column.id,
                                            operator: 'contains',
                                            value: v1
                                        });
                                    });
                                    andfilter.filters.push(orfilter);
                                    orfilter = {
                                        logic: 'or',
                                        filters: []
                                    };
                                }
                            });
                        }
                    });
                    kgrid.dataSource.filter(andfilter);
                } else {
                    kgrid.dataSource.filter({});
                }
            });
            // $('#btn-search-user').click(function() {
            //     var searchstring = $('#txt-search-user').val().toUpperCase();
            //     var kgrid = $('#data-grid-user').data('kendoGrid');
            //     var searchword = searchstring.split(" ");
            //     if (searchstring) {
            //         var orfilter = {
            //             logic: 'or',
            //             filters: []
            //         };
            //         var andfilter = {
            //             logic: 'and',
            //             filters: []
            //         };
            //         $.each(searchword, function(i, v) {
            //             if (v.trim() != '') {
            //                 $.each(searchword, function(i, v1) {
            //                     if (v1.trim() != '') {
            //                         $.each(kgrid.columns, function(key, column) {
            //                             orfilter.filters.push({
            //                                 field: column.id,
            //                                 operator: 'contains',
            //                                 value: v1
            //                             });
            //                         });
            //                         andfilter.filters.push(orfilter);
            //                         andfilter.filters.push({
            //                             field: 'us.userTypeID',
            //                             operator: 'eq',
            //                             value: 2
            //                         });
            //                         orfilter = {
            //                             logic: 'or',
            //                             filters: []
            //                         };
            //                     }
            //                 });
            //             }
            //         });
            //         kgrid.dataSource.filter(andfilter);
            //     } else {
            //         kgrid.dataSource.filter({
            //             field: 'us.userTypeID',
            //             operator: 'eq',
            //             value: 2
            //         });
            //     }
            // });
        }
        page.prototype.validation = function() {
            page.validator = $('#scriptForm').kendoValidator({
                rules: {

                },
                messages: {

                }
            }).data("kendoValidator");
        }
        page.prototype.clearform = function() {
            HTMLFormElement.prototype.reset.call($('#scriptForm')[0]);
            page.reloaddata();
        }
        page.prototype.reloaddata = function() {
            page.mode = "insert";
            page.assignID = "";
            $('#search').val('');
            $('#numGroup').data('kendoNumericTextBox').value(1);
            $('#data-grid').data('kendoGrid').dataSource.filter({});
            $('#data-grid').data('kendoGrid').dataSource.read();
            $('#data-grid').data('kendoGrid').refresh();
            $('#data-grid').data('kendoGrid').clearSelection();
        }
    }
    </script>
</body>

</html>