/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : db_nurse_psc

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 12/10/2023 03:04:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_mata_pelajaran
-- ----------------------------
DROP TABLE IF EXISTS `tbl_mata_pelajaran`;
CREATE TABLE `tbl_mata_pelajaran`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user_input` int NULL DEFAULT NULL,
  `mata_pelajaran` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_mata_pelajaran
-- ----------------------------
INSERT INTO `tbl_mata_pelajaran` VALUES (1, 2, 'Matematika');
INSERT INTO `tbl_mata_pelajaran` VALUES (2, 2, 'Bahasa');

-- ----------------------------
-- Table structure for tbl_materi
-- ----------------------------
DROP TABLE IF EXISTS `tbl_materi`;
CREATE TABLE `tbl_materi`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user_input` int NULL DEFAULT NULL,
  `id_mata_pelajaran` int NULL DEFAULT NULL,
  `materi` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_materi
-- ----------------------------
INSERT INTO `tbl_materi` VALUES (4, 2, 2, '<p><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u><strong>Materinya</strong> adalah<br/>Kesehatan <u>jasmani</u></p>');

-- ----------------------------
-- Table structure for tbl_soal
-- ----------------------------
DROP TABLE IF EXISTS `tbl_soal`;
CREATE TABLE `tbl_soal`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user_input` int NULL DEFAULT NULL,
  `id_mata_pelajaran` int NULL DEFAULT NULL,
  `soal` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `jawaban_a` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `jawaban_b` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `jawaban_c` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `jawaban_d` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `jawaban_e` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `jawaban_benar` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nilai_benar` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_soal
-- ----------------------------
INSERT INTO `tbl_soal` VALUES (5, 2, 2, 'Seorang perawat bekerja di ruang rawat inap VVIP ditugaskan membuat indikator mutu pelayanan keperawatan yang berhubungan dengan kelengkapan dokumentasi keperawatan. Berdasarkan hal tersebut, apakah indikator mutu yang sesuai dengan kaidah SMART?', 'Kelengkapan dokumentasi yg diharapkan sebesar 90%', 'Diharapkan pendokumentasian lengkap', 'Diharapkan seluruh perawat mengisi lengkap', 'Kelengkapan dokumentasi harus sesuai SOP', 'Kelengkapan dokumentasi di periksa berkala', 'E', 10);
INSERT INTO `tbl_soal` VALUES (6, 2, 2, 'Seorang perawat bekerja di ruang rawat inap VVIP ditugaskan membuat indikator mutu pelayanan keperawatan yang berhubungan dengan kelengkapan dokumentasi keperawatan. Berdasarkan hal tersebut, apakah indikator mutu yang sesuai dengan kaidah SMART?', 'Kelengkapan dokumentasi yg diharapkan sebesar 90%', 'Diharapkan pendokumentasian lengkap', 'Diharapkan seluruh perawat mengisi lengkap', 'Kelengkapan dokumentasi harus sesuai SOP', 'Kelengkapan dokumentasi di periksa berkala', 'E', 10);

-- ----------------------------
-- Table structure for tbl_status_materi
-- ----------------------------
DROP TABLE IF EXISTS `tbl_status_materi`;
CREATE TABLE `tbl_status_materi`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_materi` int NULL DEFAULT NULL,
  `id_user` int NULL DEFAULT NULL,
  `status_materi` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_status_materi
-- ----------------------------
INSERT INTO `tbl_status_materi` VALUES (1, 4, 1, 'Selesai');

-- ----------------------------
-- Table structure for tbl_status_soal
-- ----------------------------
DROP TABLE IF EXISTS `tbl_status_soal`;
CREATE TABLE `tbl_status_soal`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_soal` int NULL DEFAULT NULL,
  `id_user` int NULL DEFAULT NULL,
  `jawaban` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nilai` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_status_soal
-- ----------------------------
INSERT INTO `tbl_status_soal` VALUES (5, 5, 1, 'D', 0);
INSERT INTO `tbl_status_soal` VALUES (6, 6, 1, 'E', 10);

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tipe_user` enum('Pelajar','Pengajar') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES (1, 'pelajar', 'Laki-laki', 'malang', 'pelajar@pelajar.com', 'Pelajar', '62d16d92edb5498bf331bbe43024175749f629c0');
INSERT INTO `tbl_user` VALUES (2, 'pengajar', 'Laki-laki', 'malang', 'pengajar@pengajar.com', 'Pengajar', '1be5240a4ae368b112ac6671f8ca1973642202fc');

SET FOREIGN_KEY_CHECKS = 1;
