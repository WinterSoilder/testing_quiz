-- DropIndex
DROP INDEX `Report_level_id_key` ON `report`;

-- DropIndex
DROP INDEX `Report_question_id_key` ON `report`;

-- AddForeignKey
ALTER TABLE `Report` ADD CONSTRAINT `Report_level_id_fkey` FOREIGN KEY (`level_id`) REFERENCES `Level`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Report` ADD CONSTRAINT `Report_question_id_fkey` FOREIGN KEY (`question_id`) REFERENCES `Question`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
