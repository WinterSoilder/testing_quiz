-- CreateTable
CREATE TABLE `Answer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `question_id` INTEGER NOT NULL,
    `option_id` INTEGER NOT NULL,

    UNIQUE INDEX `Answer_question_id_key`(`question_id`),
    UNIQUE INDEX `Answer_option_id_key`(`option_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_question_id_fkey` FOREIGN KEY (`question_id`) REFERENCES `Question`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Answer` ADD CONSTRAINT `Answer_option_id_fkey` FOREIGN KEY (`option_id`) REFERENCES `Option`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
