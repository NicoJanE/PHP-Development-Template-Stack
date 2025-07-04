<?php

namespace App\Model;

class Starship
{
    public function __construct(
        private int $id,
        private string $name,
        private string $class,
        private string $captain,
        private int  $status,
    ) {
    }

    public function getId(): int
    {
        return $this->id;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function getClass(): string
    {
        return $this->class;
    }

    public function getCaptain(): string
    {
        return $this->captain;
    }

    public function getStatus(): int
    {
        return $this->status;
    }

    public function getStatusString(): string
    {
        return (string) $this->status;
    }

    public function getStatusImageFilename(): string
    {
        return match ($this->status) {
            1 => 'images/status-waiting.png',
            2 => 'images/status-in-progress.png',
            3 => 'images/status-complete.png',
        };
    }
}
